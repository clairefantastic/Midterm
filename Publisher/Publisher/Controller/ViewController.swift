//
//  ViewController.swift
//  Publisher
//
//  Created by claire on 2022/4/2.
//

import UIKit
import MJRefresh

class HomePageViewController: UIViewController {

    @IBOutlet weak var publishedArticlesTableView: UITableView! {
        
        didSet {
            
            publishedArticlesTableView.dataSource = self
            publishedArticlesTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = publishedArticlesTableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as? HomePageCell
        else { return UITableViewCell() }
        cell.articleTitleLabel.text = "good"
        return cell
        
    }
    
    
}

