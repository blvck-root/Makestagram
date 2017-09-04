//
//  HomeViewController.swift
//  Makestagram
//
//  Created by El Capitan on 8/31/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    let timestampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
    var posts = [Post]()
    
    // MARK: - Subviews
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
        
        configureTableView()
    }
    
    func configureTableView() {
        // remove  separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.PostHeaderCell, for: indexPath) as! PostHeaderCell
            cell.usernameLabel.text = User.current.username
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.PostImageCell, for: indexPath) as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.PostActionCell, for: indexPath) as! PostActionCell
            cell.delegate = self
            configureCell(cell, with: post)
            
            return cell
            
        default:
            fatalError("Error: unexpected indexPath.")
        }
    }
    
    func configureCell(_ cell: PostActionCell, with post: Post) {
        cell.likesCountLabel.text = "\(post.likeCount) likes"
        // set timeAgoLabel.text
        cell.timestampLabel.text = timestampFormatter.string(from: post.creationDate)
        cell.likeButton.isSelected = post.isLiked
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
        case 2:
            return PostActionCell.height
            
        default:
            fatalError()
        }
    }
}

// MARK: - PostActionCellDelegate

extension HomeViewController: PostActionCellDelegate {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell) {
        guard let indexPath = tableView.indexPath(for: cell)
        else { return }
        
        likeButton.isUserInteractionEnabled = false
        let post = posts[indexPath.section]
        
        LikeService.setIsLiked(!post.isLiked, for: post) { (success) in
            defer {
               likeButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
        }
        
        post.likeCount += !post.isLiked ? 1 : -1
        post.isLiked = !post.isLiked
        
        guard let cell = self.tableView.cellForRow(at: indexPath) as? PostActionCell
            else { return }
        
        DispatchQueue.main.async {
            self.configureCell(cell, with: post)
        }
        
        print("did tap like button")
    }
}
