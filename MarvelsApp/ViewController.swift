//
//  ViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CharacterDataManager.getCharacter(target: self, characterID: "1017100")
            .observe { (result) in
                switch result{
                case .value(let value):
                    print(value)
                case .error(let error):
                    print(error)
                }
        }
    }
}

