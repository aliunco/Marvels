//
//  ImageLoader.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit

protocol ImageLoader {
    func setImage(url: URL, placeholer: UIImage)
}

extension ImageLoader {
    private func downloadImage(url: URL) -> Future<UIImage?> {
        let promise = Promise<UIImage?>()
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        RequestManager.sharedSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    promise.reject(with: error ?? RequestError.emptyResponse)
                    return
            }
            promise.resolve(with: image)
        }.resume()
        return promise
    }
}


extension ImageLoader where Self: UIImageView {
    func setImage(url: URL, placeholer: UIImage) {
        self.image = placeholer
        downloadImage(url: url)
            .observe { result in
                switch result {
                case .value(let image):
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                case .error(let error):
                    print(error)
                }
        }
    }
}


extension UIImageView: ImageLoader {}
