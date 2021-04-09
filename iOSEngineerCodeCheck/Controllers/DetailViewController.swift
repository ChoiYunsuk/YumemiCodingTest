//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var searchResult: SearchRepository = SearchRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResult.notifySearchimage = self
        
        if searchResult.items.count > 0 {
            let repo = searchResult.items[searchResult.selectedRowNumber]
            
            TtlLbl.text = "\(repo["full_name"] as? String ?? "")"
            LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
            StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
            WchsLbl.text = "\(repo["watchers_count"] as? Int ?? 0) watchers"
            FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
            IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
            searchResult.getImage()
        }
    }
}

// MARK - NotifySearchImageFinished(Image検索終了後)
extension DetailViewController: NotifySearchImageFinished {
    func didSearchedIamge(_ controller: SearchRepository, img: UIImage, message: Bool) {
        if message == true {
            self.ImgView.image = img
        }
    }
}
