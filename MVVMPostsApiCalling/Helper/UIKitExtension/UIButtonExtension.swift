

import Foundation
import UIKit

extension UIButton {
    func underline() {
            guard let text = self.titleLabel?.text else { return }
            let attributedString = NSMutableAttributedString(string: text)
            //NSAttributedStringKey.foregroundColor : UIColor.blue
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    func setImagesTintColor(color:UIColor,arrState:[UIControl.State]) {
        for state in arrState {
            if let image = self.image(for: state) {
                let newImage = image.withRenderingMode(.alwaysTemplate)
                self.setImage(newImage, for: state)
            }
        }
        self.tintColor = color
    }
    
    func setTitleForAllState(string:String) {
        let arr : [UIControl.State] = [.normal,.selected,.highlighted,.disabled]
        for state in arr {
            self.setTitle(string, for: state)
        }
    }
    
}


