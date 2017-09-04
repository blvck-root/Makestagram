//
//  PostService.swift
//  Makestagram
//
//  Created by El Capitan on 9/2/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

@available(iOS 10.0, *)
struct PostService {
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        let dict = post.dictValue
        
        let postRef = Database.database().reference().child(Constants.FirebaseNodes.posts).child(currentUser.uid).childByAutoId()
        postRef.updateChildValues(dict)
    }
}
