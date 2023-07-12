//
//  PostModel.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import Foundation

public struct PostModel : Codable
{
    var userId : Int
    var id : Int
    var title : String
    var body : String
}
