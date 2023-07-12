//
//  PostViewModel.swift
//  MVVMPostsApiCalling
//
//  Created by AnkurPipaliya on 11/07/23.
//

import Foundation

class PostViewModel {
 
    let url = "https://jsonplaceholder.typicode.com/posts/"
    let commentUrl = "https://jsonplaceholder.typicode.com/posts/"
    let endPoint = "/comments"
    var posts : [PostModel] = []
    //https://jsonplaceholder.typicode.com/posts/USER_ID/comments

   // var posts = [PostModel(userId: "1", id: "1", title: "1", body: "1"),
   // PostModel(userId: "2", id: "2", title: "2", body: "2")]
    
    func fetchPostsfromApi(completion: @escaping (Result<[PostModel],Error>) -> Void){
        HTTPManager.shared.get(urlString: url) { [weak self] ress in
            guard let self = self else {return}
            switch ress {
            case .failure(let err):
                print ("failure", err)
            case .success(let dat):
                let decoder = JSONDecoder()
                do {
                    self.posts = try decoder.decode([PostModel].self, from: dat)
                    completion(.success(try decoder.decode([PostModel].self, from: dat)))
                } catch let err{
                    print("error in completon \(err)")
                }
            }
        }
    }
    
    func fetchCommentsFromApi(_ id:Int ,completion: @escaping (Result<[CommentModel],Error>) -> Void) {
        HTTPManager.shared.get(urlString: url + "\(id)" + endPoint) { [weak self] resss in
            guard let self = self else {return }
            
            switch resss{
            case .failure(let err):
                print("failue comment api " , err)
            case .success(let det):
                let decoder = JSONDecoder()
                do {
                   // self.comments = try decoder.decode([CommentModel].self, from: det)
                    //completion(.success(try decoder.decode([CommentModel].self, from: det)))
                } catch let err{
                    print("error in completon \(err)")
                }
            }
        }
    }
}
