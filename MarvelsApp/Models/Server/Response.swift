//
//  Response.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Decodable {
    var code: Int?
    var status: String?
    var etag: String? //digit value of the content
    var copyright: String? //The copyright notice for the returned result
    var attributionText: String? //The attribution notice for this result
    var attributionHTML: String? //An HTML representation of the attribution notice for this result
    var data: Container<T>?
}


struct Container<T: Codable> : Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [T]?
}

struct ServerError: Decodable {
    var code: Int?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message = "status"
    }
}


enum RequestError: Error {
    case withServerError(error: ServerError)
    case preRequest(message: String)
    case emptyResponse
}
