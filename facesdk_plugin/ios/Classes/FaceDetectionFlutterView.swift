import Foundation
import AVFoundation
import Flutter

@available(iOS 10.0, *)
class FaceDetectionFlutterView : NSObject, FlutterPlatformView, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate{
    let channel: FlutterMethodChannel
    let frame: CGRect
    let captureSession = AVCaptureSession()

    var cameraLens: AVCaptureDevice.Position!
    var cameraRunning: Bool = false
    var cameraViewInited: Bool = false
    var startTime: Double = 0

    var cameraView : UIView!
    let dummyLayout = CAShapeLayer()

    init(registrar: FlutterPluginRegistrar, viewId: Int64, frame: CGRect) {
        self.channel = FlutterMethodChannel(name: "facedetectionview_" + String(viewId), binaryMessenger: registrar.messenger())
        self.frame = frame
     }
       
    public func setMethodHandler() {
        self.channel.setMethodCallHandler({ (FlutterMethodCall,  FlutterResult) in
                let args = FlutterMethodCall.arguments
                let myArgs = args as? [String: Any]
                if FlutterMethodCall.method == "startCamera" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.startCamera(cameraLens: (myArgs?["cameraLens"] ) as! Int)
                    }
                } else if FlutterMethodCall.method == "stopCamera" {
                    self.stopCamera()
                } 
            })
    }   
    
    func view() -> UIView {
        if cameraView == nil {
            self.cameraView = UIView(frame: frame)
        }

        return cameraView
    }
    
    func startCamera(cameraLens: Int) {
        if(cameraRunning == true) { return } 

        self.cameraLens = cameraLens == 1 ? .front : .back

        captureSession.sessionPreset = .hd1280x720
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: self.cameraLens) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)

        if(cameraViewInited == false) {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.cameraView.bounds.width, height: self.cameraView.bounds.height), cornerRadius: 0)
            dummyLayout.path = path.cgPath
            dummyLayout.fillColor = UIColor.black.cgColor
            dummyLayout.frame = cameraView.frame

            self.cameraView.layer.addSublayer(previewLayer)
            self.cameraView.layer.addSublayer(dummyLayout)

            previewLayer.frame = self.cameraView.frame

            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(dataOutput)

            cameraViewInited = true
        }

        cameraRunning = true
        startTime = Date().timeIntervalSince1970

        captureSession.startRunning()
    }

    func stopCamera() {
        captureSession.stopRunning()
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }

        cameraRunning = false
        self.dummyLayout.fillColor = UIColor.black.cgColor
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            self.dummyLayout.fillColor = UIColor.clear.cgColor
        }

       if(Date().timeIntervalSince1970 - startTime <= 0.5) {
            return
        }

        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
               
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags.readOnly)
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        let context = CIContext()
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        let image = UIImage(cgImage: cgImage!)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags.readOnly)

        var capturedImage = image.rotate(radians: .pi/2)
        if(self.cameraLens == .front) {
            capturedImage = capturedImage.flipHorizontally()
        }
        
        let faceBoxes = FaceSDK.faceDetection(capturedImage)
        var faceBoxesMap = NSMutableArray()
        for face in (faceBoxes as NSArray as! [FaceBox]) {
            let templates = FaceSDK.templateExtraction(capturedImage, faceBox: face)
            let faceImage = capturedImage.cropFace(faceBox: face)
            let faceJpg = faceImage!.jpegData(compressionQuality: CGFloat(1.0))

            var faceDic = Dictionary<String, Any>()
            faceDic["x1"] = face.x1
            faceDic["y1"] = face.y1
            faceDic["x2"] = face.x2
            faceDic["y2"] = face.y2
            faceDic["liveness"] = face.liveness
            faceDic["yaw"] = face.yaw
            faceDic["roll"] = face.roll
            faceDic["pitch"] = face.pitch
            faceDic["templates"] = templates
            faceDic["faceJpg"] = faceJpg
            faceDic["frameWidth"] = Int(capturedImage.size.width)
            faceDic["frameHeight"] = Int(capturedImage.size.height)

            faceBoxesMap.add(faceDic)
        }

        DispatchQueue.main.async {
            var faceBoxesArray = faceBoxesMap as Array
            self.channel.invokeMethod("onFaceDetected", arguments: faceBoxesArray)
        }
    }    
}
