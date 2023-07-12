//
//  Dictionary+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit



extension Dictionary {
    func dictionaryByReplacingNullsWithBlanks() -> Dictionary<AnyHashable,Any> {
        guard var replaced = self as? [AnyHashable:Any] else {
            return self
        }
        let blank = ""
        for (keydict,value) in self {
            let key = keydict
            
            let object = value
            if object is NSNull {
                replaced[key] = blank
            } else if object is [AnyHashable : Any],let objectNew = object as? [AnyHashable : Any] {
                replaced[key] = objectNew.dictionaryByReplacingNullsWithBlanks()
            } else if object is [AnyHashable],let objectNew = object as? [AnyHashable] {
                replaced[key] = objectNew.arrayByReplacingNullsWithBlanks()
            }
        }
        return replaced
    }
}

extension Array {
    
    func arrayByReplacingNullsWithBlanks() -> Array<Any> {
        guard var replaced = self as? [Any] else {
            return self
        }
        let blank = ""
        for idx in 0..<replaced.count {
            let object = replaced[idx]
            if object is NSNull {
                replaced[idx] = blank
            } else if object is [AnyHashable : Any],let objectNew = object as? [AnyHashable : Any] {
                replaced[idx] = objectNew.dictionaryByReplacingNullsWithBlanks()
            } else if object is [AnyHashable],let objectNew = object as? [AnyHashable] {
                replaced[idx] = objectNew.arrayByReplacingNullsWithBlanks()
            }
        }
        return replaced
    }

    mutating func appendAtBeginning(newItem : Element){
        let copy = self
        self = []
        self.append(newItem)
        self.append(contentsOf: copy)
    }
    
    func first(elementCount: Int) -> Array {
          let min = Swift.min(elementCount, count)
          return Array(self[0..<min])
    }
    
    
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}

extension Dictionary {
    var queryString: String {
       var output: String = ""
       for (key,value) in self {
           output +=  "\(key)=\(value)&"
       }
       output = String(output.dropLast())
       return output
    }
 }

