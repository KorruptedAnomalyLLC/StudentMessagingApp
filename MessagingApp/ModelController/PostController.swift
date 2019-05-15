//
//  PostController.swift
//  MessagingApp
//
//  Created by Austin West on 5/13/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation

class PostController {
    
    let baseURL = URL(string: "http://devmtn-posts.firebaseio.com/posts")
    
    
    //    Source of Truth
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping() -> Void) {
        guard let unwrappedURL = baseURL else { completion(); return }
        let getterEndpoint = unwrappedURL.appendingPathExtension("json")
        
        var request = URLRequest(url: getterEndpoint)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data else { completion(); return}
            
            let decoder = JSONDecoder()
            
            do {
                let postsDictionary = try decoder.decode([String:Post].self, from: data)
                var posts: [Post] = postsDictionary.compactMap({ $0.value })
                posts.sort(by: { $0.timestamp > $1.timestamp })
                self.posts = posts
                completion()
            } catch {
                print(error)
                return
            }
        }
        dataTask.resume()
    }
}
