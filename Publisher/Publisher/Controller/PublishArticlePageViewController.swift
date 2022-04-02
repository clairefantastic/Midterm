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
    
    var authorEmail: String?
    
    var authorId: String?
    
    var authorName: String?
    
    var publishedArticle = PublishedArticle(articleTitle: "", articleCategory: "", articleContent: "")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = nil

        navigationItem.hidesBackButton = true

    }
    
    @IBAction func publishArticle(_ sender: Any) {
        
        authorEmail = "wayne@school.appworks.tw"
        
        authorId = "wayne@school.appworks.tw"
        
        authorName = "AKA小安老師"
        
        if (authorId != nil) && (authorEmail != nil)  && (authorName != nil) {
                
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
