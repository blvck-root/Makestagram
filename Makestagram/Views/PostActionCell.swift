//
//  PostActionCell.swift
//  Makestagram
//
//  Created by El Capitan on 9/3/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit

class PostActionCell: UITableViewCell {
    
    static let height: CGFloat = 46
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
    }
}
