

import Foundation
import  UIKit

extension UIFont {
    
    class func families() {
        for family in UIFont.familyNames {
            print(family)
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
    
    class func font_Roboto_Semibold(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Roboto_Bold.rawValue, size: size)!;
    }
    
    class func font_Roboto_Regular(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Roboto_Regular.rawValue, size: size)!;
    }
    
    class func font_Roboto_Medium(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Roboto_Medium.rawValue, size: size)!;
    }
    
    class func font_Roboto_Bold(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Roboto_Bold.rawValue, size: size)!;
    }
    
    
    class func font_Roboto_Light(size : CGFloat) -> UIFont {
        return UIFont(name: Resources.Fonts.Weight.Roboto_Light.rawValue, size: size)!;
    }

}


struct Resources {

    struct Fonts {
        //struct is extended in Fonts
    }
}

extension Resources.Fonts {

    enum Weight: String {
        case Roboto_Regular = "Roboto-Regular"
        case Roboto_Italic = "Roboto-Italic"
        case Roboto_Thin = "Roboto-Thin"
        case Roboto_ThinItalic = "Roboto-ThinItalic"
        case Roboto_Light = "Roboto-Light"
        case Roboto_LightItalic = "Roboto-LightItalic"
        case Roboto_Medium = "Roboto-Medium"
        case Roboto_MediumItalic = "Roboto-MediumItalic"
        case Roboto_Bold = "Roboto-Bold"
        case Roboto_BoldItalic = "Roboto-BoldItalic"
        case Roboto_Black = "Roboto-Black"
        case Roboto_BlackItalic = "Roboto-BlackItalic"
        
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

   
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage": // Regular
            fontName = Resources.Fonts.Weight.Roboto_Regular.rawValue
        case "CTFontMediumUsage": // Medium
            fontName = Resources.Fonts.Weight.Roboto_Medium.rawValue
        case "CTFontLightUsage": // Light
            fontName = Resources.Fonts.Weight.Roboto_Light.rawValue
        case "CTFontSemiboldUsage","CTFontDemiUsage": // SemiBold
//                        print("=======>>>>>>> ",fontAttribute)
            fontName = Resources.Fonts.Weight.Roboto_Bold.rawValue
        case "CTFontBoldUsage":
            fontName = Resources.Fonts.Weight.Roboto_Bold.rawValue // Bold
        case "CTFontEmphasizedUsage","CTFontHeavyUsage", "CTFontBlackUsage": // Bold
            fontName = Resources.Fonts.Weight.Roboto_Bold.rawValue
            
        default:
            fontName = fontAttribute
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideDefaultTypography() {
        guard self == UIFont.self else { return }

//        if let systemFontMethodWithWeight = class_getClassMethod(self, #selector(systemFont(ofSize: weight:))),
//            let mySystemFontMethodWithWeight = class_getClassMethod(self, #selector(mySystemFont(ofSize: weight:))) {
//            method_exchangeImplementations(systemFontMethodWithWeight, mySystemFontMethodWithWeight)
//        }
//
//        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
//            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
//            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
//        }
//
//        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
//            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//        }
//
//        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
//            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
