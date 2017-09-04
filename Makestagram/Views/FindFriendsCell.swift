//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by El Capitan on 9/4/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit

protocol FindFriendsCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell)
}

class FindFriendsCell: UITableViewCell {
    
    weak var delegate: FindFriendsCellDelegate?
    
    // MARK: - Properties
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
    }
    
    // MARK: - IBActions
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        delegate?.didTapFollowButton(sender, on: self)
    }
    
}
