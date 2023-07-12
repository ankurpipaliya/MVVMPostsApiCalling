//
//  APISecurity.swift
//  
//
//  Created by MitulPatel on 16/03/21.
//  Copyright © 2021 Harshil Panchal. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

//    //MARK: Timestamp
func GetCurrentTimeStamp() -> String {
    let df = DateFormatter()
    let date = NSDate()
    df.dateFormat = "yyyyMMddhhmmss"
    let NewDate = df.string(from: date as Date)
    return NewDate.replacingOccurrences(of: ":", with: "")
}
/*
public func getAutheticationToken() -> (nonce : String, timeStamp : String, token : String){
    let nonce = 6.randomString // "6IdglW"
    let timestamp = GetCurrentTimeStamp() // "20210316102848"
    let token = createHashedTokenString(timeStemp: timestamp, randomStr: nonce) // "309f31762ea3d64f37b35306f3f3a39ed0c22fb2cb023ed7ebebcba973aa19d7"
    
    return (nonce,timestamp,token)
}*/

/*
//MARK: Create Token
func createHashedTokenString(timeStemp : String , randomStr :  String) -> String {
//    var str = String(format: "%@=%@&%@=%@","nonce", randomStr, "timestamp",timeStemp)
    var str = ConstantURL.kSecret + timeStemp + randomStr
    print(str)
    str = str.hmac(algorithm: .SHA256, key:ConstantURL.kPrivateKey)
    return str
}*/




extension String {
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result: result, length: digestLen)
        
        result.deallocate()
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}


enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}


//MARK: CREATE RANDOM STRING of LENGTH
extension Int{
    var randomString : String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: self)
        
        for _ in 0 ..< self{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
}
