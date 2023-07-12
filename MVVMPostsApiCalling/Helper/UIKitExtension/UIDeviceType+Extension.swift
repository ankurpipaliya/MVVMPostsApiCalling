//
//  UIDeviceType+Extension.swift
//  BaseCode
//
//  Created by Apple on 23/01/21.
//

import Foundation
import UIKit


//if you want more deatils then go here use Logical Height and Logical Width
//https://ios-resolution.com/
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_876sSE2nd          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_678Plus         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
    static let IS_IPAD_PRO129          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
    static let IS_IPAD_PRO11          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1194.0
    static let IS_IPAD_PRO105Air          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1112.0
    
    static let IS_IPHONE_11ProMaxXRXSMAX      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPHONE_X11ProXS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    
    static let IS_IPHONE_12MINI        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 780.0
    
    static let IS_IPHONE_12Pro         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 844.0
    
    static let IS_IPHONE_12ProMAX        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 926.0
    
}



//MARK:- UIDevice Extension
extension UIDevice {
    enum DeviceTypes {
        case iPad
        case iPadPro
        case iPhone4_4s
        case iPhone5_5s
        case iPhone6_6s
        case iPhone6p_6ps
        case iPhoneX_XS
        case iPhone_XSMAX_XR
        case after_iPhoneXSMAX
    }
    
    static var deviceType : DeviceTypes {
        
        switch UIScreen.main.bounds.height
        {
        case 480.0:
            return .iPhone4_4s
        case 568.0:
            return .iPhone5_5s
        case 667.0:
            return .iPhone6_6s
        case 736.0:
            return .iPhone6p_6ps
        case 812.0:
            return .iPhoneX_XS
        case 896.0:
            return .iPhone_XSMAX_XR
        case 1024.0:
            return .iPad
        case 1366.0:
            return .iPadPro
        default:
            return .after_iPhoneXSMAX
        }
        
    }
}
