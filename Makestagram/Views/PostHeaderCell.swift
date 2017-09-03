//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by El Capitan on 9/3/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped.")
    }
}
