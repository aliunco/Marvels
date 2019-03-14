//
//  CharacterDataManager.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

struct CharacterDataManager {
    
    static func getCharacters(target: LoadingPresenter?, name: String? = nil, limit: Int? = nil, offset: Int? = nil) -> Future<Response<Character>> {
        
        //cancel previous request
        RequestManager.lastTask?.cancel()
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characters(name: name, limit: limit, offset: offset).path,
            params: MarvelApi.characters(name: name, limit: limit, offset: offset).parameters,
            type: .background,
            modelType: Response<Character>.self
        )
    }
    
    static func getCharacter(target: LoadingPresenter?, characterID: String) -> Future<Response<Character>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.character(characterID: characterID).path,
            params: MarvelApi.character(characterID: characterID).parameters,
            type: .foreground,
            modelType: Response<Character>.self
        )
    }
    
    static func getComics(target: LoadingPresenter?, characterID: String) -> Future<Response<Comic>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characterComics(characterID: characterID, limit: 3).path,
            params: MarvelApi.characterComics(characterID: characterID, limit: 3).parameters,
            type: .background,
            modelType: Response<Comic>.self
        )
    }
    
    static func getSeries(target: LoadingPresenter?, characterID: String) -> Future<Response<Series>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characterSeries(characterID: characterID, limit: 3).path,
            params: MarvelApi.characterSeries(characterID: characterID, limit: 3).parameters,
            type: .background,
            modelType: Response<Series>.self
        )
    }
    
    static func getEvents(target: LoadingPresenter?, characterID: String) -> Future<Response<Event>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characterEvents(characterID: characterID, limit: 3).path,
            params: MarvelApi.characterEvents(characterID: characterID, limit: 3).parameters,
            type: .background,
            modelType: Response<Event>.self
        )
    }
    
    static func getStories(target: LoadingPresenter?, characterID: String) -> Future<Response<Story>> {
        return RequestManager.shared.fetch(
            method: .get,
            target: target,
            path: MarvelApi.characterStories(characterID: characterID, limit: 3).path,
            params: MarvelApi.characterStories(characterID: characterID, limit: 3).parameters,
            type: .background,
            modelType: Response<Story>.self
        )
    }

}
