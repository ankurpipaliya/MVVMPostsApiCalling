

import Foundation
import UIKit

extension UITextField {
    
    func addLeftPadding(padding: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding , height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = leftView
    }
    
    func addRightPadding(padding: CGFloat) {
        let leftView = UIView(frame: CGRect(x: self.frame.size.width-padding, y: 0, width: padding , height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = leftView
    }
    
    func addRightViewImage(image: String) {
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.frame = CGRect(x: 0, y: 0, width: 30 , height: self.frame.size.height)
        imageView.contentMode = .center
        self.rightViewMode = .always
        self.rightView = imageView
    }
    
    func addLeftViewImage(image: String) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height , height: self.frame.size.height))
        
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.frame = CGRect(x: 0, y: 5, width: view.frame.size.height - 10 , height: view.frame.size.height - 10)
        imageView.layer.cornerRadius = 3.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        
        self.leftViewMode = .always
        self.leftView = view
    }
    
    func setLeftLabel(_ text : String) {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        lbl.textAlignment = .center
        lbl.text = text
//        lbl.font = UIFont(name: Font_500, size: 14.0)
        lbl.textColor = UIColor.lightGray
        
        self.leftViewMode = .always
        self.leftView = lbl
    }
    
    func disableTextField() {
        self.isEnabled = false
    }
}

extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector,datePicker:UIDatePicker) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        //    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        //    datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}

extension UITextView {
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
}


extension UITextField {

    /// Runtime key
    private struct AssociatedKeys {
        /// max lenght key
        static var maxlength: UInt8 = 0
        /// temp string key
        static var tempString: UInt8 = 0
    }

    /// Limit the maximum input length of the textfiled
    @IBInspectable var maxLength: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.maxlength) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.maxlength, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTarget(self, action: #selector(handleEditingChanged(textField:)), for: .editingChanged)
        }
    }

    /// temp string
    private var tempString: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempString) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempString, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// When the text changes, process the amount of text in the input box so that its length is within the controllable range.
    @objc private func handleEditingChanged(textField: UITextField) {

        /// Special Processing for Chinese Input Method
        guard markedTextRange == nil else { return }

        if textField.text?.count == maxLength {

            /// SET lastQualifiedString where text length == max lenght
            tempString = textField.text
        } else if textField.text?.count ?? 0 < maxLength {

            /// clear lastQualifiedString when text lengeht > maxlength
            tempString = nil
        }

        /// keep current text range in arcgives
        let archivesEditRange: UITextRange?

        if textField.text?.count ?? 0 > maxLength {

            /// if text length > maxlength,remove last range,to move to -1 postion.
            let position = textField.position(from: safeTextPosition(selectedTextRange?.start), offset: -1) ?? textField.endOfDocument
            archivesEditRange = textField.textRange(from: safeTextPosition(position), to: safeTextPosition(position))
        } else {

            /// just set current select text range
            archivesEditRange = selectedTextRange
        }

        /// main handle string max length
        textField.text = tempString ?? String((textField.text ?? "").prefix(maxLength))

        /// last config edit text range
        textField.selectedTextRange = archivesEditRange
    }

    /// get safe textPosition
    private func safeTextPosition(_ optionlTextPosition: UITextPosition?) -> UITextPosition {

        /* beginningOfDocument -> The end of the the text document. */
        return optionlTextPosition ?? endOfDocument
    }
}
