//
//  SearchRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by Yunsuk Choi on 2021/04/04.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol SearchedDelegate {
    func didSearchedRepository(_ controller: SearchRepository, message: Bool)
}

class SearchRepository {
    
    let baseURL: String = "https://api.github.com/search/repositories?q="
    
    var searchTargetWord: String
    var task: URLSessionTask?
    var items: [[String: Any]]=[]
    
    var delegate: SearchedDelegate?
    
    init() {
        searchTargetWord = ""
    }
    
    init(searchTarget word: String) {
        searchTargetWord = word
    }
    
    func test() {
        
        var targetURL: String
        
        if searchTargetWord.count != 0 {
            targetURL = baseURL + searchTargetWord
            task = URLSession.shared.dataTask(with: URL(string: targetURL)!) { (data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let result = obj["items"] as? [[String: Any]] {
                        self.items = result
                        DispatchQueue.main.async {
                            // delegateで実装しているが、知らせる箇所が増えるとObserverに変更した方がいいかも
                            if self.delegate != nil {
                                self.delegate?.didSearchedRepository(self, message: true)
                            }
                        }
                    }
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }
}
