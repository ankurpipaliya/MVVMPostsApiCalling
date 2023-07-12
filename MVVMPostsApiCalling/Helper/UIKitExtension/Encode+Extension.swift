//
//  Encode+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
