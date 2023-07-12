
import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func sd_setImageCustom(url:String,placeHolderImage:UIImage? = nil,complation : ((UIImage?)->())? = nil) {
        
        if let url = URL(string: url) {
            let indicator : SDWebImageActivityIndicator = SDWebImageActivityIndicator.gray
            indicator.indicatorView.color = .gray
            self.sd_imageIndicator = indicator//SDWebImageActivityIndicator.gray
            self.sd_setImage(with: url, placeholderImage: placeHolderImage, options: .transformAnimatedImage) { (image, error, catchImage, url) in
                if let error = error {
                    //print("Image URL : ",String(describing: url))
                    //print("SDError : ",error)
                    ez.runThisInMainThread {
                        self.image = placeHolderImage
                        complation?(nil)
                    }
                    return
                }
                
                guard let image = image else {
                    ez.runThisInMainThread {
                        self.image = placeHolderImage
                        complation?(nil)
                    }
                    return
                }
                
                ez.runThisInMainThread {
                    self.image = image
                    complation?(image)
                }
            }
        }else {
            ez.runThisInMainThread {
                self.image = placeHolderImage
                complation?(nil)
            }
        }
    }
    
}


extension UIImage {
    
    func getTintColourImage() -> UIImage {
        let templateImage = self.withRenderingMode(.alwaysTemplate)
        return templateImage
    }
    
    
}


extension UIImageView{
    func imageFrame()->CGRect{
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else{return CGRect.zero}
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        }else{
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }
}
extension UIImage {
    func croppedInRect(rect: CGRect) -> UIImage {
        func rad(_ degree: Double) -> CGFloat {
            return CGFloat(degree / 180.0 * .pi)
        }

        var rectTransform: CGAffineTransform
        switch imageOrientation {
        case .left:
            rectTransform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
        case .right:
            rectTransform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
        case .down:
            rectTransform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
        default:
            rectTransform = .identity
        }
        rectTransform = rectTransform.scaledBy(x: self.scale, y: self.scale)

        let imageRef = self.cgImage!.cropping(to: rect.applying(rectTransform))
        let result = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return result
    }
    
    
    func resizeImage(imageWidth : CGFloat) -> UIImage? {
        let size = self.size
        
        let aspectRatio =  size.height / size.width
        
        let widthNew  = imageWidth
        let heightNew = imageWidth * aspectRatio

        // Figure out what our orientation is, and use that to form the rectangle
        let newSize: CGSize = CGSize(width: widthNew, height: heightNew)
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
}
