//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by El Capitan on 9/2/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import Foundation
import FirebaseStorage

@available(iOS 10.0, *)
extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timeStamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timeStamp).jpg")
    }
}
