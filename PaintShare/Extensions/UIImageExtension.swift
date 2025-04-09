//
//  UIImageExtension.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

extension UIImage {
//    func cropsToSquare() -> UIImage {
//        let refWidth = CGFloat((self.cgImage!.width))
//        let refHeight = CGFloat((self.cgImage!.height))
//        let cropSize = refWidth > refHeight ? refHeight : refWidth
//
//        let x = (refWidth - cropSize) / 2.0
//        let y = (refHeight - cropSize) / 2.0
//
//        let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize)
//        let imageRef = self.cgImage?.cropping(to: cropRect)
//        let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: self.imageOrientation)
//
//        return cropped
//    }
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func resize(height: CGFloat) -> UIImage? {
            let ratio = height / size.height

            let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)

            UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
            draw(in: CGRect(origin: .zero, size: resizedSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return resizedImage
        }
}
