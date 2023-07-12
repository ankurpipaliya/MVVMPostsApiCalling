//
//  CommentModel.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import Foundation

//CommentModel
public struct CommentModel : Codable
{
    var postId : Int
    var id : Int
    var name: String
    var email : String
    var body : String
}
