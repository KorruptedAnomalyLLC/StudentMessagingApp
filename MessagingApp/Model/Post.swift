//
//  Post.swift
//  MessagingApp
//
//  Created by Austin West on 5/13/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let username: String
    let text: String
    let timestamp: TimeInterval
    
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        
        self.username = username
        self.text = text
        self.timestamp = timestamp
    }
    
}
