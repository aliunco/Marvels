//
//  APIManager.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

fileprivate struct MarvelKeys {
    var privateKey: String = "5b7b02b7cc48e6cf0e8f5738dbdc49b86c2f4376"
    var publicKey: String = "b266b93f61a3d794cab44558525b1e63"
}

fileprivate struct MarvelAPIConfig {
    
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.privateKey
    static let apikey = keys.publicKey
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".MD5()
    static let authParameters: [String: String] = [
        "apikey": MarvelAPIConfig.apikey,
        "ts": MarvelAPIConfig.ts,
        "hash": MarvelAPIConfig.hash
    ]
}

enum MarvelApi {
    case characters(name: String?, limit: Int?, offset: Int?)
    case character(characterID: String)
    case characterComics(characterID: String)
    case characterEvents(characterID: String)
    case characterSeries(characterID: String)
    case characterStories(characterID: String)
    //TODO: continue for the rest of the content apis
}

extension MarvelApi {
    
    var path: String {
        switch self {
        case .characters:
            return "/public/characters"
        case .character(let characterId):
            return "/public/characters/\(characterId)"
        case .characterComics(let characterID):
            return "/v1/public/characters/\(characterID)/comics"
        case .characterEvents(let characterID):
            return "/v1/public/characters/\(characterID)/events"
        case .characterSeries(let characterID):
            return "/v1/public/characters/\(characterID)/series"
        case .characterStories(let characterID):
            return "/v1/public/characters/\(characterID)/stories"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .characters(let name, let limit, let offset):
            var params: [String: Any] = [:]
            if let name = name { params = params.merge(dict: ["nameStartsWith": name])}
            if let limit = limit { params = params.merge(dict: ["limit": limit])}
            if let offset = offset { params = params.merge(dict: ["offset": offset])}
            return (MarvelAPIConfig.authParameters as [String: Any]).merge(dict: params)
        default:
            return MarvelAPIConfig.authParameters
        }
    }
}


