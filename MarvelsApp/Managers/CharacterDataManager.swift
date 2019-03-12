//
//  CharacterDataManager.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

struct CharacterDataManager {
    
    static func getCharacters(target: Any?, name: String? = nil, limit: Int? = nil, offset: Int? = nil) -> Future<Response<Character>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characters(name: name, limit: limit, offset: offset).path,
            params: MarvelApi.characters(name: name, limit: offset, offset: offset).parameters,
            type: .foreground,
            modelType: Response<Character>.self
        )
    }
    
    static func getCharacter(target: Any?, characterID: String) -> Future<Response<Character>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.character(characterID: characterID).path,
            params: MarvelApi.character(characterID: characterID).parameters,
            type: .foreground,
            modelType: Response<Character>.self
        )
    }
}
