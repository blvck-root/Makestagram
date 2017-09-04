//
//  FollowService.swift
//  Makestagram
//
//  Created by El Capitan on 9/4/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    private static func followUser (_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : true,
                          "following/\(currentUID)/\(user.uid)" : true]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            success(error == nil)
        }
    }
    
    private static func unfollowUser (_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : true,
                          "following/\(currentUID)/\(user.uid)" : false]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            success(error == nil)
        }
    }
    
    // MARK: - Is Current User following user
    
    static func isUserFollowed(_ user: User, withCompletion completion: @escaping (Bool) -> Void) {
        let followingRef = Database.database().reference().child("following").child(user.uid)
        followingRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String: Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        if isFollowing {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    
}
