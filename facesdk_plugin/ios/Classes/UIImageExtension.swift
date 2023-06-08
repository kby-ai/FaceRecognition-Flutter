import Foundation
import UIKit


public extension UIImage {
    
    func cropFace(faceBox: FaceBox) -> UIImage? {
        let centerX = Int((faceBox.x1 + faceBox.x2) / 2)
        let centerY = Int((faceBox.y1 + faceBox.y2) / 2)
        let cropWidth = Int(Float(faceBox.x2 - faceBox.x1) * Float(1.4))
        
        let cropX1 = Int(Float(centerX) - Float(cropWidth / 2))
        let cropX2 = Int(Float(centerY) - Float(cropWidth / 2))
        let cropRect = CGRect(x: CGFloat(cropX1), y: CGFloat(cropX2), width: CGFloat(cropWidth), height: CGFloat(cropWidth))
        
        guard let croppedImage = self.cgImage!.cropping(to: cropRect) else { return nil }
        
        let faceImage = UIImage(cgImage: croppedImage)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 150, height: 150))
        let newImage = renderer.image { (context) in
            faceImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 150, height: 150)))
        }
        return newImage
    }
    
    /// Extension to fix orientation of an UIImage without EXIF
    func fixOrientation() -> UIImage {
        
        guard let cgImage = cgImage else { return self }
        
        if imageOrientation == .up { return self }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
            
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y	: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            
        case .up, .upMirrored:
            break
        }
        
        switch imageOrientation {
            
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
            
        case .up, .down, .left, .right:
            break
        }
        
        if let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            
            ctx.concatenate(transform)
            
            switch imageOrientation {
                
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
                
            default:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
            
            if let finalImage = ctx.makeImage() {
                return (UIImage(cgImage: finalImage))
            }
        }
        
        // something failed -- return original
        return self
    }
    
    func rotate(radians: CGFloat) -> UIImage {
            let rotatedSize = CGRect(origin: .zero, size: size)
                .applying(CGAffineTransform(rotationAngle: radians))
                .integral.size
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext() {
                context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
                context.rotate(by: radians)
                draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return rotatedImage ?? self
            }
            return self
        }
        
        // Extension to flip UIImage horizontally
        func flipHorizontally() -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: size.width, y: 0)
            context.scaleBy(x: -1.0, y: 1.0)
            draw(in: CGRect(origin: .zero, size: size))
            let flippedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return flippedImage
        }
}
