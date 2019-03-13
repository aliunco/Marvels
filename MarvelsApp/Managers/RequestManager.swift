//
//  RequestManager.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit

public enum HTTPMethod : String {
    case get, post, put, patch, delete
}

public enum ApiRequestExecutionType {
    case foreground, background, container
}

public typealias Parameters = [String : Any]


struct RequestManager {
    
    private var baseUrl: String
    static var lastTask: URLSessionTask?
    var defaultHeaders: [String: String]?
    
    static private(set) var shared: RequestManager = {
        if let apiBaseUrl = AppUtility.getInfoConfigs(for: "baseUrl"),
            let apiVersion = AppUtility.getInfoConfigs(for: "apiVersion") {
            return RequestManager(with: "\(apiBaseUrl)/\(apiVersion)")
        }
        return RequestManager(with: "")
    }()
    
    static private(set) var sharedSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }()
    
    init(with baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func fetch<T> (
        method: HTTPMethod,
        target: LoadingPresenter?,
        path: String,
        params: Parameters?,
        type: ApiRequestExecutionType,
        modelType: T.Type
        ) -> Future<T> where T : Decodable {
        let promise = Promise<T>()
    
        
        guard let requestUrl = "\(baseUrl)\(path)".addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            promise.reject(with: RequestError.preRequest(message: "request URL encoding prolem!"))
            return promise
        }
        
        self.preRequestActions(target: target, type: type, url: requestUrl, params: params)
        // ---- preparing the http request -----
        var request: URLRequest?
        switch method {
        case .post, .put:
            guard let url = URL(string: "\(requestUrl))")  else {
                promise.reject(with: RequestError.preRequest(message: "request URL type"))
                return promise
            }
            request = URLRequest(url: url)
            //TODO: set httpBody here for post & put requets via params
        default:
            let query = params?.queryString ?? ""
            guard let url = URL(string: "\(requestUrl)\(query.count > 0 ? "?\(query)" : "")") else {
                promise.reject(with: RequestError.preRequest(message: "request URL type"))
                return promise
            }
            request = URLRequest(url: url)
        }
        // ------ end of preparing the request
        
        guard let httpRequest = request else {
            promise.reject(with: RequestError.preRequest(message: "Unexpected error Happened!"))
            return promise
        }
        printRequest(url: requestUrl, params: params)
        RequestManager.lastTask = RequestManager.sharedSession.dataTask(with: httpRequest) { (data, response, error) in
            self.afterRequestActions(target: target, type: type, data: data, response: response, error: error)
            if let error = error {
                promise.reject(with: error)
                return
            }
            
            guard let header = response as? HTTPURLResponse else {
                promise.reject(with: RequestError.emptyResponse)
                return
            }
            guard let data = data else {
                promise.reject(with: RequestError.emptyResponse)
                return
            }
            if header.statusCode == 200 {
                self.decode(data: data, modelType: modelType)
                    .observe(with: { (result) in
                        switch result {
                        case .value(let value):
                            promise.resolve(with: value)
                        case .error(let error):
                            promise.reject(with: error)
                        }
                    })
            } else {
                
                self.decode(data: data, modelType: ServerError.self)
                    .observe(with: { (result) in
                        switch result {
                        case .value(let value):
                            promise.reject(with: RequestError.withServerError(error: value))
                        case .error(let error):
                            promise.reject(with: error)
                        }
                    })
            }
            
        }
        RequestManager.lastTask?.resume()
        return promise
    }
    
    private func preRequestActions(target: LoadingPresenter?, type: ApiRequestExecutionType, url: String, params: Parameters?) {
        if(type == .container || type == .foreground) {
            loadingIndicator(present: true)
            target?.presentLoadingView(visible: true)
        }
    }
    
    private func afterRequestActions(target: LoadingPresenter?, type: ApiRequestExecutionType, data: Data?, response: URLResponse?, error: Error?) {
        guard let response = response as? HTTPURLResponse else {
            loadingIndicator(present: false)
            target?.presentLoadingView(visible: false)
            return
        }
        if response.statusCode == 200 {
            if (type == .foreground) {
                loadingIndicator(present: false)
                target?.presentLoadingView(visible: false)
            }
        } else {
            if(type == .container || type == .foreground) {
                loadingIndicator(present: false)
                target?.presentLoadingView(visible: false)
            }
        }
        self.printResponse(url: response.url?.absoluteString ?? "", data: data)
    }
    
    private func decode<T>(data: Data, modelType: T.Type) -> Future<T> where T : Decodable {
        let promise = Promise<T>()
        do {
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-zzzz"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let model = try decoder.decode(modelType.self, from: data)
            promise.resolve(with: model)
        } catch let parsingError {
            print("Error", parsingError)
            promise.reject(with: parsingError)
        }
        return promise
    }
    
    
    private func printRequest(url: String, params: Parameters?) {
        print("------------ Start request for : \(url)")
        if let params = params {
            print(params)
        }
    }
    
    private func printResponse(url: String, data: Data?) {
        if let data = data, let utf8Text = String(data: data, encoding: .utf8) {
            print("------------ Start response for : \(url)")
            print("DataResponse: \(utf8Text)")
        }
    }
    
    private func loadingIndicator(present: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = present
        }
    }

}
