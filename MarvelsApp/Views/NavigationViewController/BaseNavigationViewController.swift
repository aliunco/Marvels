//
//  BaseNavigationViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customizing navbar
        let navbarAppearance = UINavigationBar.appearance()
        navbarAppearance.tintColor = .white
        navbarAppearance.barTintColor = .primary1
        navbarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
