//
//  AlertUIViewController+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    @discardableResult
    public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    
    @discardableResult public func showAlertSheet(title: String?, message: String?,attributedTitle:NSMutableAttributedString?,attributedMessage:NSMutableAttributedString?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        if let attributedTitle = attributedTitle {
            alertController.setTitletAttributed(string: attributedTitle)
        }
        
        if let attributedMessage = attributedMessage {
            alertController.setMessageAttributedString(string: attributedMessage)
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action : UIAlertAction?
            if buttonTitle == "Cancel" {
                action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                    completion?(index)
                })
            }else{
                action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                    completion?(index)
                })
                action?.setValue(UIColor.black, forKey: "titleTextColor")
            }
            if let action = action {
                alertController.addAction(action)
            }
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
                
            }
            
            // Check which button to highlight
            
        }
        
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    func showNoNetworkAlert(strBtnTitle:String = "",complationNoNetwork:(()->())? = nil) {
        
        let alertController = UIAlertController(title: "", message: "no_internet_connection", preferredStyle: .alert)
        let action = UIAlertAction(title: strBtnTitle.isBlank ? "Okay" : strBtnTitle, style: .default, handler: { (_) in
            complationNoNetwork?()
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertWithOkAndCancelHandler(string: String,strOk:String,strCancel : String,handler: @escaping (_ isOkBtnPressed : Bool)->Void)
    {
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
        
        let alertOkayAction = UIAlertAction(title: strOk, style: .default) { (alert) in
            handler(true)
        }
        let alertCancelAction = UIAlertAction(title: strCancel, style: .default) { (alert) in
            handler(false)
        }
        alert.addAction(alertCancelAction)
        alert.addAction(alertOkayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(string:String,handler: (()->())? = nil) {
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let alertOkayAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            handler?()
        }
        alert.addAction(alertOkayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    public func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    func setTitletAttributed(string:NSMutableAttributedString) {
        self.setValue(string, forKey: "attributedTitle")
    }
    
    func setMessageAttributedString(string:NSMutableAttributedString) {
        self.setValue(string, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
    
  
}
