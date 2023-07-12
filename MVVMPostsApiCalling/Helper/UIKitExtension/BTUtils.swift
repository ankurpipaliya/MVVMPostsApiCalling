//
//  BTUtils.swift
//  BLEDemo
//
//  Created by Jindrich Dolezy on 28/11/2018.
//  Copyright © 2018 Dzindra. All rights reserved.
//

import CoreBluetooth


extension Data {
    func parseBool() -> Bool {
        guard count == 1 else { return false }
        
        return self[0] != 0 ? true : false
    }
    
    func parseInt() -> UInt8? {
        guard count == 1 else { return nil }
        return self[0]
    }
    
    func parseUInt64() -> UInt64? {

        let i64array = self.withUnsafeBytes { $0.load(as: UInt64.self) }
        return i64array
    }
    
    func parseUInt32() -> UInt32? {

        let i32Val = self.withUnsafeBytes { $0.load(as: UInt32.self) }
        return i32Val
    }
    
    func parseUtf8() -> String? {
        let utf8Str = String(data: self, encoding: .utf8)
        return utf8Str
    }
    
    //Convert to UInt32
   var uint32: UInt32 {
        get {
            let i32array = self.withUnsafeBytes { $0.load(as: UInt32.self) }
            return i32array
        }
    }
    
    //Convert in to bytesArray
    var bytesArray : [UInt8] {
        return [UInt8](self)
    }
    
    func hexaEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined().uppercased()
    }
}



//UInt 8 to data
extension UInt8 {
    
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt8>.size)
    }
    
    //Single Hex Value
    func getHexVal() -> String {
        String(format:"%02X", self)
    }
    
}

//UInt16 to data
extension UInt16 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt16>.size)
    }
}


//UInt16 to data
extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
}


//UInt 8 to data
extension UInt64 {
    
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt64>.size)
    }
}



extension Array where Element == UInt8 {
    var hexString: String {
        return self.compactMap { String(format: "%02x", $0).uppercased() }
        .joined(separator: ":")
    }
    
}

extension BinaryInteger {
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        var counter = 0

        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
            counter += 1
            if counter % 4 == 0 {
                binaryString.insert(contentsOf: " ", at: binaryString.startIndex)
            }
        }

        return binaryString
    }
}

extension Int {
    
    //From Decimal
    //10 -> 2
    func decToBinString() -> String {
        let result = createString(radix: 2)
        return result
    }
    
    //10 -> 8
    func decToOctString() -> String {
        //        let result = decToOctStringFormat()
        let result = createString(radix: 8)
        
        return result
    }
    
    //10 -> 16
    func decToHexString() -> String {
        //        let result = decToHexStringFormat()
        let result = createString(radix: 16)
        return result
    }
    
    //10 -> 8
    func decToOctStringFormat(minLength: Int = 0) -> String {
        
        return createString(minLength: minLength, system: "O")
    }
    
    //10 -> 16
    func decToHexStringFormat(minLength: Int = 0) -> String {
        
        return createString(minLength: minLength, system: "X")
    }
    
    fileprivate  func createString(radix: Int) -> String {
        return String(self, radix: radix, uppercase: true)
    }
    
    fileprivate func createString(minLength: Int = 0, system: String) -> String {
        //0 - fill empty space by 0
        //minLength - min count of chars
        //system - system number
        return String(format:"%0\(minLength)\(system)", self)
    }
    
}
extension Int {
    var boolValue: Bool {
        return (self as NSNumber).boolValue
    }
}
extension String {
    
    //To Decimal
    //2 -> 10
    func binToDec() -> Int {
        return createInt(radix: 2)
    }
    
    //8 -> 10
    func octToDec() -> Int {
        return createInt(radix: 8)
    }
    
    //16 -> 10
    func hexToDec() -> Int {
        return createInt(radix: 16)
    }
    
    //Others
    //2 -> 8
    func binToOct() -> String {
        return self.binToDec().decToOctString()
    }
    
    //2 -> 16
    func binToHex() -> String {
        return self.binToDec().decToHexString()
    }
    
    //8 -> 16
    func octToHex() -> String {
        return self.octToDec().decToHexString()
    }
    
    //16 -> 8
    func hexToOct() -> String {
        return self.hexToDec().decToOctString()
    }
    
    //16 -> 2
    func hexToBin() -> String {
        return self.hexToDec().decToBinString()
    }
    
    //8 -> 2
    func octToBin() -> String {
        return self.octToDec().decToBinString()
    }
    
    //Additional
    //16 -> 2
    func hexToBinStringFormat(minLength: Int = 0) -> String {
        
        return hexToBin().pad(minLength: minLength)
    }
    
    fileprivate func pad(minLength: Int) -> String {
        let padCount = minLength - self.count
        
        guard padCount > 0 else {
            return self
        }
        
        return String(repeating: "0", count: padCount) + self
    }
    
    fileprivate func createInt(radix: Int) -> Int {
        return Int(self.replacingOccurrences(of: "x", with: "0"), radix: radix) ?? 0
    }
    
    func hexToFloat() -> Float {
        var toInt = Int32(_truncatingBits: strtoul(self, nil, 16)) //For Swift 5
        var float = Float32()
        print(self)
        memcpy(&float, &toInt, MemoryLayout.size(ofValue: float))
        return float
    }
    
    func toHexEncodedString(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
            return unicodeScalars.map { prefix + .init($0.value, radix: 16, uppercase: uppercase) } .joined(separator: separator)
        }
    
}

extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}

extension Float {
    func floatToHex()->String {
        return String(self.bitPattern, radix: 16, uppercase: true)
    }
}
