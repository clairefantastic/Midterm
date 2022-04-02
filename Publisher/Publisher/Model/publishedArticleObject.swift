//
//  publishedArticleObject.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import Foundation

struct PublishedArticle {
    
    var articleTitle: String
    
    var articleCategory: String
     
    var articleContent: String
    
    var author: Author
    
}

struct Author {
    
    var authorName: String
    
    var authorEmail: String
    
    var authorId: String
}


