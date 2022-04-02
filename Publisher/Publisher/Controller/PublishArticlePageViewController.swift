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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func publishArticle(_ sender: Any) {
        
        firebaseManager.addData()
        self.navigationController?.popViewController(animated: true)
    }
}
