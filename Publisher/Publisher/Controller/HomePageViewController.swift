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
    
    @IBOutlet weak var addNewArticleButton: UIButton!
    
    @IBOutlet weak var buttonBackgroundView: UIView!
    
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
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        buttonBackgroundView.layer.cornerRadius = buttonBackgroundView.frame.height / 2.0
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
    
    func convertTimestamp(serverTimestamp: TimeInterval) -> String {

        let timeStamp = serverTimestamp
        // 將時間戳轉換成 TimeInterval
        let timeInterval = TimeInterval(timeStamp)
        // 初始化一個 Date
        let date = Date(timeIntervalSince1970: timeInterval)
        // 實例化一個 DateFormatter
        let dateFormatter = DateFormatter()
        // 設定日期格式
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        // 將日期轉換成 string 輸出給 today
        let today = dateFormatter.string(from: date)
        print("Time Stamp's Current Time:\(today)")
        
        return today
    }
    
    func addSnapshotListener() {

        db.collection("articles").order(by: "createdTime", descending: false).addSnapshotListener { (querySnapshot, err) in
            
            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {
                
                querySnapshot?.documentChanges.forEach({ (documentChange) in
                    
                if documentChange.type == .added {
                   
                    self.publishedArticles.insert(documentChange.document.data(), at: 0)
                    
                    print(self.publishedArticles)

                }
                })
            }
        }
//        self.publishedArticlesTableView.reloadData()
        
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
       
        let author = publishedArticles[indexPath.row]?["author"] as? [String: Any]
        
        cell.authorNameLabel.text = author?["name"] as? String
        
        cell.categoryLabel.text = publishedArticles[indexPath.row]?["category"] as? String
        
        let time = publishedArticles[indexPath.row]?["createdTime"]
    
        cell.createdTimeLabel.text = self.convertTimestamp(serverTimestamp: time as? TimeInterval ?? 0)
        
        cell.articleContentLabel.text =  publishedArticles[indexPath.row]?["content"] as? String
        
        return cell
        
    }
    
    
}

