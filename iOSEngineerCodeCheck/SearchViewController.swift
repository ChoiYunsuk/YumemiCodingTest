//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController{

    // 変数名を全般的に直す。
    @IBOutlet weak var SchBr: UISearchBar!
    @IBOutlet var searchResultTableView: UITableView!
    
    // 要るか要らないか確認
    var idx: Int!
    
    let searchRepos = SearchRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
        
        // 検索結果表示TableViewのCell登録
        searchResultTableView.register(SearchResultCell.nib(), forCellReuseIdentifier: SearchResultCell.cellIdentifier)
        
        searchRepos.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail"{
            let dtl = segue.destination as! DetailViewController
            dtl.vc1 = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRepos.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.cellIdentifier, for: indexPath) as! SearchResultCell
                    
        let repos = searchRepos.items[indexPath.row]
        
        cell.fullNameLabel?.text = repos["full_name"] as? String ?? ""
        cell.languageLabel?.text = repos["language"] as? String ?? ""
        cell.tag = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索するWordセット
        searchRepos.searchTargetWord = searchBar.text!
        // 検索実行
        searchRepos.test()
    }
}

//MARK: - SearchedDelegate（レポジトリ検索終了お知らせ）
extension SearchViewController: SearchedDelegate {
    func didSearchedRepository(_ controller: SearchRepository, message: Bool) {
        if message == true {
            self.tableView.reloadData()
        }
    }
}
