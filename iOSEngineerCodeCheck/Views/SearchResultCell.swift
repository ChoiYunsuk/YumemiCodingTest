//
//  SearchResultCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Yunsuk Choi on 2021/04/04.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet var fullNameLabel: UILabel!
    
    static let cellIdentifier = "SearchResultCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchResultCell", bundle: nil)
    }
 
    public func configure() {
        fullNameLabel.text = "test"
    }
}
