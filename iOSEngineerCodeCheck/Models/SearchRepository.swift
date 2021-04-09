//
//  SearchRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by Yunsuk Choi on 2021/04/04.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol NotifySearchFinished {
    func didSearchedRepository(_ controller: SearchRepository, message: Bool)
}

protocol NotifySearchImageFinished {
    func didSearchedIamge(_ controller: SearchRepository, img: UIImage, message: Bool)
}

class SearchRepository {
    
    var task: URLSessionTask?
    let baseURL: String = "https://api.github.com/search/repositories?q="
    // 検索する単語
    var searchWord: String
    // 検索結果
    var items: [[String: Any]]=[]
    // 検索終了後viewcontrollerに知らせるため
    var notifySearch: NotifySearchFinished?
    var notifySearchimage: NotifySearchImageFinished?
    
    var selectedRowNumber: Int = 0
    
    init() {
        searchWord = ""
    }
    
    init(searchTarget word: String) {
        searchWord = word
    }
    
    func execute() {
        
        var targetURL: String
        
        if searchWord.count != 0 {
            targetURL = baseURL + searchWord
            task = URLSession.shared.dataTask(with: URL(string: targetURL)!) { (data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let result = obj["items"] as? [[String: Any]] {
                        self.items = result
                        DispatchQueue.main.async {
                            // delegateで実装しているが、知らせる箇所が増えるとObserverに変更した方がいいかも
                            if self.notifySearch != nil {
                                self.notifySearch?.didSearchedRepository(self, message: true)
                            }
                        }
                    }
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }
    
    func getImage() {
        
        let repo = self.items[self.selectedRowNumber]
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        if self.notifySearchimage != nil {
                            self.notifySearchimage?.didSearchedIamge(self, img: img, message: true)
                        }
                    }
                }.resume()
            }
        }
    }
}
