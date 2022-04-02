//
//  PublishArticlePageViewController.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import UIKit
import Foundation

class PublishArticlePageViewController: UIViewController {
    
    let firebaseManager = FirebaseManager()
    
    @IBOutlet weak var inputTitleTextField: UITextField!
    
    @IBOutlet weak var inputCategoryTextField: UITextField!
    
    @IBOutlet weak var inputContentTextField: UITextField!
    
    @IBOutlet weak var publishArticleButton: UIButton!
    
    var publishedArticle = PublishedArticle(articleTitle: "", articleCategory: "", articleContent: "", author: Author(authorName: "", authorEmail: "", authorId: ""))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = nil

        navigationItem.hidesBackButton = true

    }
    
    @IBAction func publishArticle(_ sender: Any) {
        
        publishedArticle.author.authorEmail = "wayne@school.appworks.tw"
        
        publishedArticle.author.authorId = "waynechen323"
        
        publishedArticle.author.authorName = "AKA小安老師"
        
        if (publishedArticle.author.authorEmail != "") && (publishedArticle.author.authorName != "")  && (publishedArticle.author.authorId != "") {
                
            publishedArticle.articleTitle = inputTitleTextField?.text ?? ""
                
            publishedArticle.articleCategory = inputCategoryTextField?.text ?? ""
                
            publishedArticle.articleContent = inputContentTextField?.text ?? ""
                
            firebaseManager.addData(publishedArticle)
                
            self.navigationController?.popViewController(animated: true)
            
        } else {
            
            let action = UIAlertAction(title: "OK", style: .default, handler: {action in})
            
            let authorInfoAlert = UIAlertController(title: "Error", message: "Author Info should exist", preferredStyle: .alert)
            
            authorInfoAlert.addAction(action)
            
            present(authorInfoAlert, animated: true)
            
        }
         
    }
}
