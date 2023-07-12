//
//  DispatchQueue+Extension.swift
//  BaseCode
//
//  Created by Apple on 22/01/21.
//

import Foundation
import UIKit


func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func mainQueue(completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}
