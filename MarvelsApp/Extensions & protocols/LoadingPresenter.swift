//
//  LoadingPresenter.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

protocol LoadingPresenter {
    
    var loadingView: LoadingCoverView? { get }
    func presentLoadingView(visible: Bool)
    
}

extension LoadingPresenter where Self: UIView {
    
    var loadingView: LoadingCoverView? {
        return LoadingCoverView.shared
    }
    
    func presentLoadingView(visible: Bool) {
        DispatchQueue.main.async {
            self.loadingView?.isHidden = !visible
            guard let loading = self.loadingView else { return }
            if visible, loading.superview != self {
                loading.frame = self.frame
                self.addSubview(loading)
            }
        }
    }
    
}

extension LoadingPresenter where Self: UIViewController {
    
    var loadingView: LoadingCoverView? {
        return LoadingCoverView.shared
    }
    
    func presentLoadingView(visible: Bool) {
        DispatchQueue.main.async {
            self.loadingView?.isHidden = !visible
            guard let loading = self.loadingView else { return }
            if visible, loading.superview != self.view {
                loading.frame = self.view.frame
                self.view.addSubview(loading)
            }
        }
    }
}

extension UIView: LoadingPresenter {}
extension UIViewController: LoadingPresenter {}
