//
//  ImageLoader.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit


public struct ImageLoaderWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ImageLoaderCompatible { }
extension ImageLoaderCompatible {
    public var il: ImageLoaderWrapper<Self> {
        get { return ImageLoaderWrapper(self) }
        set {}
    }
}

extension ImageLoaderWrapper {
    private func downloadImage(url: URL, callBack:@escaping ((UIImage) -> Void)) -> URLSessionDataTask {
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        let task = RequestManager.sharedSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            callBack(image)
        }
        task.resume()
        return task
    }
}

extension ImageLoaderWrapper where Base: UIImageView {
    @discardableResult func setImage(url: URL, placeholer: UIImage) -> URLSessionDataTask {
        self.base.image = placeholer
        return downloadImage(url: url) { (image) in
            DispatchQueue.main.async {
                self.base.image = image
            }
        }
    }
}


extension UIImageView: ImageLoaderCompatible { }
