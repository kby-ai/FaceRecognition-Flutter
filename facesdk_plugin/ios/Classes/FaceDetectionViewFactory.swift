import Foundation
import Flutter

@available(iOS 10.0, *)
class FaceDetectionViewFactory : NSObject, FlutterPlatformViewFactory {
    
    let registrar:FlutterPluginRegistrar
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let faceDetectionFlutterView = FaceDetectionFlutterView(registrar: self.registrar, viewId: viewId, frame: frame)
        faceDetectionFlutterView.setMethodHandler()
        return faceDetectionFlutterView
    }
   
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
}
