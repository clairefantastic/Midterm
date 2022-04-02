//
//  FirebaseManager.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import Foundation
import Firebase

class FirebaseManager {
    
    func addData(_ article: PublishedArticle) {
        
        let articles = Firestore.firestore().collection("articles")
        
        let document = articles.document()
        
        let data: [String: Any] = [
            
            "author": [
                
                "email": "\(article.author.authorEmail)",
                
                "id": "\(article.author.authorId)",
                
                "name": "\(article.author.authorName)"
                
            ],
            
            "title": "\(article.articleTitle)",
            
            "content": "\(article.articleContent)",
            
            "createdTime": Date().timeIntervalSince1970,
            
            "id": document.documentID,
            
            "category": "\(article.articleCategory)"
        ]
        
        document.setData(data)
    }
}

