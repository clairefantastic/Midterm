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
                "email": "wayne@school.appworks.tw",
                "id": "waynechen323",
                "name": "AKA小安老師"
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

