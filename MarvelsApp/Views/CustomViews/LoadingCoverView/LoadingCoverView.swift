//
//  LoadingCoverView.swift
//  Bamilo
//
//  Created by Ali Saeedifar on 12/31/17.
//  Copyright © 2017 Zibazi. All rights reserved.
//

import UIKit

class LoadingCoverView: BaseCustomView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private(set) static var shared: LoadingCoverView? = {
       return LoadingCoverView.viewFromNib()
    }()
    
    override func setup() {
        self.backgroundColor = .clear
        self.loadingIndicator.startAnimating()
        self.containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        self.containerView.alpha = 0.8
        self.backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.backgroundView.alpha = 0.7
        self.containerView.layer.cornerRadius = 5
    }
}
