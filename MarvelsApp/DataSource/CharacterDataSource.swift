//
//  CharacterDataSource.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

protocol CharacterDataSourceDelegate: class, LoadingPresenter {
    func resourceUpdated()
}

enum CharacterSectionInfo {
    case basicInfo(name: String, description: String)
    case series(title: String, items: [SimplePresentable])
    case events(title: String, items: [SimplePresentable])
    case stories(title: String, items: [SimplePresentable])
    case comics(title: String, items: [SimplePresentable])
}

final class CharacterDataSource: NSObject {
    
    var dataSource: [CharacterSectionInfo] = []
    weak var delegate: CharacterDataSourceDelegate?
    
    var character: Character?
    private var series: [Series]? { didSet { checkInfosForUpdateSectionInfo() } }
    private var events: [Event]? { didSet { checkInfosForUpdateSectionInfo() } }
    private var stories: [Story]? { didSet { checkInfosForUpdateSectionInfo() } }
    private var comics: [Comic]? { didSet { checkInfosForUpdateSectionInfo() } }
    
    func loadData(with characterID: String) {
        CharacterDataManager.getCharacter(target: delegate, characterID: characterID)
            .observe { (result) in
                switch result{
                case .value(let characterResponse):
                    DispatchQueue.main.async {
                        self.character = characterResponse.data?.results?.first
                        self.loadMoreInfo()
                        self.updateSectionInfo()
                    }
                case .error(let error):
                    print(error)
                }
        }
    }
    
    func loadMoreInfo() {
        guard let characterID = self.character?.id else { return }
        CharacterDataManager.getComics(target: delegate, characterID: "\(characterID)")
            .observe { switch $0 { case .value(let response): self.comics = response.data?.results case .error(_): self.comics = []}}
        CharacterDataManager.getSeries(target: delegate, characterID: "\(characterID)")
            .observe { switch $0 { case .value(let response): self.series = response.data?.results case .error(_): self.series = []}}
        CharacterDataManager.getStories(target: delegate, characterID: "\(characterID)")
            .observe { switch $0 { case .value(let response): self.stories = response.data?.results case .error(_): self.stories = []}}
        CharacterDataManager.getEvents(target: delegate, characterID: "\(characterID)")
            .observe { switch $0 { case .value(let response): self.events = response.data?.results case .error(_): self.events = []}}
    }
    
    func checkInfosForUpdateSectionInfo() {
        guard let _ = series, let _ = events, let _ = stories, let _ = comics else { return }
        DispatchQueue.main.async {
            self.updateSectionInfo()
        }
    }
    
    func updateSectionInfo() {
        dataSource.removeAll()
        if let name = self.character?.name, let desc = self.character?.description {
            dataSource.append(.basicInfo(name: name, description: desc))
        }
    
        if let comics = comics, comics.count > 0 { dataSource.append(.comics(title: "Comics", items: comics)) }
        if let events = events, events.count > 0 { dataSource.append(.events(title: "Events", items: events)) }
        if let stories = stories, stories.count > 0 { dataSource.append(.stories(title: "Stories", items: stories)) }
        if let series = series, series.count > 0 { dataSource.append(.series(title: "Series",items: series)) }
        
        self.delegate?.resourceUpdated()
    }
}
