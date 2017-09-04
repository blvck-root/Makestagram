//
//  UserService.swift
//  Makestagram
//
//  Created by El Capitan on 8/30/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child(Constants.FirebaseNodes.users).child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child(Constants.FirebaseNodes.users).child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func posts(for user: User, completion: @escaping ([Post]) -> Void) {
        let ref = Database.database().reference().child(Constants.FirebaseNodes.posts).child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let dispatchGroup = DispatchGroup()
            
            let posts: [Post] = snapshot
                .reversed()
                .flatMap {
                    guard let post = Post(snapshot: $0)
                        else { return nil}
                    
                    dispatchGroup.enter()
                    
                    LikeService.isPostLiked(post){ (isLiked) in
                        post.isLiked = isLiked
                        
                        dispatchGroup.leave()
                    }
                    
                    return post
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(posts)
            })
        })
    }
    
    static func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
        let currentUser = User.current
        let ref = Database.database().reference().child(Constants.FirebaseNodes.users)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            let users =
            snapshot
            .flatMap(User.init)
                .filter { $0.uid != currentUser.uid }
            
            let dispacthGroup = DispatchGroup()
            users.forEach { (user) in
                dispacthGroup.enter()
                
                FollowService.isUserFollowed(user) { (isFollowed) in
                    user.isFollowed = isFollowed
                    dispacthGroup.leave()
                }
            }
                dispacthGroup.notify(queue: .main, execute: {
                    completion(users)
                })
        })
    }
        
}


