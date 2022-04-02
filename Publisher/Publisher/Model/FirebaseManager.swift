//
//  FirebaseManager.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import Foundation
import Firebase

class FirebaseManager {
    
    func addData() {
        let articles = Firestore.firestore().collection("articles")
        let document = articles.document()
        let data: [String: Any] = [
            "author": [
                "email": "wayne@school.appworks.tw",
                "id": "waynechen323",
                "name": "AKA小安老師"
            ],
            "title": "IU「亂穿」竟美出新境界！笑稱自己品味奇怪　網笑：靠顏值撐住女神氣場",
            "content": "南韓歌手IU（李知恩）無論在歌唱方面或是近期的戲劇作品都有亮眼的成績，但俗話說人無完美、美玉微瑕，曾在跟工作人員的互動影片中坦言自己品味很奇怪，近日在IG上分享了宛如「媽媽們青春時代的玉女歌手」超復古穿搭造型，卻意外美出新境界。",
    "createdTime": Timestamp(date: Date()),
    "id": document.documentID,
    "category": "Beauty"
    ]
    document.setData(data)
    }
}

