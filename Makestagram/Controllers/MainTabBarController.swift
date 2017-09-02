//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by El Capitan on 8/31/17.
//  Copyright © 2017 Mthabisi Ndlovu. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let photoHelper = MGPhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
    
}

@available(iOS 10.0, *)
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            // present photo taking action
            photoHelper.presentActionSheet(from: self)
            
            return false
            
        } else {
            
            return true
            
        }
    }
}
