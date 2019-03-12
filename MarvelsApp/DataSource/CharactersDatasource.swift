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
    func listHasBeenUpdated()
}

final class CharactersDatasource: NSObject {
    
    var items: [Character] = []
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
            self.delegate?.listHasBeenUpdated()
        }
    }
    
    func getMoreItems() {
        CharacterDataManager.getCharacters(target: delegate, name: query, limit: itemsPerPage, offset: self.items.count)
            .observe { result in
                switch result{
                case .value(let characters):
                    DispatchQueue.main.async {
                        self.items.append(contentsOf: characters.data?.results ?? [])
                        self.delegate?.listHasBeenUpdated()
                    }
                case .error(let error):
                    print(error)
                }
        }
    }

}
