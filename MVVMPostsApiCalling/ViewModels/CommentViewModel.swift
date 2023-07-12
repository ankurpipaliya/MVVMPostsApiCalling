//
//  commentViewModel.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import Foundation

class CommentViewModel {
 
    let url = "https://jsonplaceholder.typicode.com/posts/"
    let commentUrl = "https://jsonplaceholder.typicode.com/posts/"
    let endPoint = "/comments"
    var comments : [CommentModel] = []
    
    //https://jsonplaceholder.typicode.com/posts/USER_ID/comments
    
    func fetchCommentsFromApi(_ id:Int ,completion: @escaping (Result<[CommentModel],Error>) -> Void) {
        HTTPManager.shared.get(urlString: url + "\(id)" + endPoint) { [weak self] resss in
            guard let self = self else {return }
            
            switch resss{
            case .failure(let err):
                print("failue comment api " , err)
            case .success(let det):
                let decoder = JSONDecoder()
                do {
                    self.comments = try decoder.decode([CommentModel].self, from: det)
                    completion(.success(try decoder.decode([CommentModel].self, from: det)))
                } catch let err{
                    print("error in completon \(err)")
                }
            }
        }
    }
}
