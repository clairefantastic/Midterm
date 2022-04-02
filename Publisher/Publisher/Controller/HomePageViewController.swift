//
//  ViewController.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import UIKit
import MJRefresh
import Firebase

class HomePageViewController: UIViewController {

    let db = Firestore.firestore()
    
    let author = Author()
    
    @IBOutlet weak var addNewArticleButton: UIButton!
    
    @IBOutlet weak var publishedArticlesTableView: UITableView! {
        
        didSet {
            
            publishedArticlesTableView.dataSource = self
            
            publishedArticlesTableView.delegate = self
        }
    }
    
    var publishedArticles: [[String: Any]?] = [] {

        didSet {

            publishedArticlesTableView.reloadData()

        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSnapshotListener()
        addRefreshHeader()
    }
    
    
    @IBAction func addNewArticle(_ sender: Any) {
        
        guard let PublishArticlePageViewController = storyboard?.instantiateViewController(withIdentifier: "\(PublishArticlePageViewController.self)") as? PublishArticlePageViewController else { return }
        
        self.navigationController?.pushViewController(PublishArticlePageViewController, animated: true)
    
    }
    
    func addRefreshHeader() {
          MJRefreshNormalHeader { [weak self] in
            // load some data
              self?.publishedArticlesTableView.mj_header?.endRefreshing()
          }.autoChangeTransparency(true)
          .link(to: publishedArticlesTableView)
      }
    
    func addSnapshotListener() {

        db.collection("articles").order(by: "createdTime", descending: true).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                querySnapshot?.documentChanges.forEach({ (documentChange) in
                if documentChange.type == .added {
                    
                   
                    self.publishedArticles.insert(documentChange.document.data(), at: 0)
                    print(self.publishedArticles)
                    
//                    publishedArticles.insert( documentChange.document.data(), at: 0)
//  self.currentSender.append(documentChange.document.data()["sender"] as! String)
//                    self.currentID.append(documentChange.document.documentID)
//                    self.friendInvitationsTableView.reloadData()
                }
                })
            }
        }
        self.publishedArticlesTableView.reloadData()
        
    }
    
    

}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publishedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = publishedArticlesTableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as? HomePageCell
        else { return UITableViewCell() }
        cell.articleTitleLabel.text = publishedArticles[indexPath.row]?["title"] as? String
        cell.authorNameLabel.text = author.authorName
        cell.categoryLabel.text = publishedArticles[indexPath.row]?["category"] as? String
        cell.createdTimeLabel.text = publishedArticles[indexPath.row]?["createdTime"] as? String
        cell.articleContentLabel.text =  publishedArticles[indexPath.row]?["content"] as? String
        return cell
        
    }
    
    
}

