//
//  CharactersDatasource.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit

protocol CharactersDatasourceDelegate:class, LoadingPresenter {
    func listHasBeenUpdated(newItems: [Character])
    func startLoading()
}

final class CharactersDatasource: NSObject {
    
    var items: [Character] = []
    var isInProgress = false
    var delegate: CharactersDatasourceDelegate?
    private let itemsPerPage = 20
    var query: String? {
        didSet {
            resetAndClear()
            getMoreItems()
        }
    }

    func resetAndClear() {
        DispatchQueue.main.async {
            self.items.removeAll()
            self.delegate?.listHasBeenUpdated(newItems: [])
        }
    }
    
    func getMoreItems() {
        if isInProgress { return }
        isInProgress = true
        
        DispatchQueue.main.async { self.delegate?.startLoading() }
        CharacterDataManager.getCharacters(target: delegate, name: query, limit: itemsPerPage, offset: self.items.count)
            .observe { result in
                self.isInProgress = false
                switch result{
                case .value(let characters):
                    DispatchQueue.main.async {
                        let newItems = characters.data?.results ?? []
                        self.items.append(contentsOf: newItems)
                        self.delegate?.listHasBeenUpdated(newItems: newItems)
                    }
                case .error(let error):
                    print(error)
                    self.delegate?.listHasBeenUpdated(newItems: [])
                }
        }
    }

}
