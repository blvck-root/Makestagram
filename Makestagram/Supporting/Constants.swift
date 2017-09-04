//
//  Constants.swift
//  Makestagram
//
//  Created by El Capitan on 8/30/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
    
    struct Cells {
        static let PostHeaderCell = "PostHeaderCell"
        static let PostImageCell = "PostImageCell"
        static let PostActionCell = "PostActionCell"
        static let FindFriendsCell = "FindFriendsCell"
    }
    
    struct FirebaseNodes {
        static let users = "users"
        static let posts = "posts"
        static let postLikes = "postLikes"
    }
}
