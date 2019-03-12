//
//  Entity.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

fileprivate func convertURL(urlString: String?) -> URL? {
    if let urlString = urlString { return URL(string: urlString) }
    return nil
}

struct URLObj: Codable {
    var type: String?
    var urlString: String?
    var url: URL? { return convertURL(urlString: urlString) }
    private enum CodingKeys: String, CodingKey {
        case type
        case urlString = "url"
    }
}

struct Text: Codable {
    var type: String?
    var language: String?
    var text: String?
}

struct Image: Codable {
    var path: String?
    var type: String?
    private enum CodingKeys: String, CodingKey {
        case type = "extension"
    }
}

extension Image {
    func getUrl() -> URL? {
        guard let path = path, let type = type else { return nil }
        return URL(string: "\(path).\(type)")
    }
}

struct ResourceList<T: Codable> : Codable {
    var available: Int?
    var returned: Int? //The number of resources returned in this resource list (up to 20).
    var collectionURIString: String?
    var items: [T]?
    
    private enum CodingKeys: String, CodingKey {
        case available, returned, items
        case collectionURIString = "collectionURI"
    }
}

struct Character: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: Date?
    var resourceURIString: String?
    var urls: [URLObj]?
    var thumbnail: Image?
    var comics: ResourceList<Comic>?
    var stories: ResourceList<Story>?
    var events: ResourceList<Event>?
    var series: ResourceList<Series>?
    var resourceURI: URL? { return convertURL(urlString: resourceURIString) }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, modified, urls, thumbnail, comics, stories, events, series
        case resourceURIString = "resourceURI"
    }
}

struct Comic: Codable {
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var description: String?
    var modified: Date?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [Text]?
    var resourceURIString: String?
    var urls: [URLObj]?
    var series: Series?
    var thumbnail: Image?
    var images: [Image]?
    var creators: ResourceList<Creator>?
    var characters: ResourceList<Character>?
    var stories: ResourceList<Story>?
    var events: ResourceList<Event>?
    
    private enum CodingKeys: String, CodingKey {
        case id, digitalId, title, issueNumber, variantDescription, description, modified, isbn,
            upc,diamondCode, ean, issn, format, pageCount, textObjects,
            urls, series, thumbnail, images, creators, characters, stories, events
        case resourceURIString = "resourceURI"
    }
}

struct Story: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURIString: String?
    var type: String?
    var modified: Date?
    var thumbnail: Image?
    var comics: ResourceList<Comic>?
    var series: ResourceList<Series>?
    var events: ResourceList<Event>?
    var characters: ResourceList<Character>?
    var creators: ResourceList<Creator>?
    var resourceURI: URL?{ return convertURL(urlString: resourceURIString) }
    private enum CodingKeys: String, CodingKey {
        case id, title, description, type, modified,
            thumbnail, comics, series, events, characters, creators
        case resourceURIString = "resourceURI"
    }
}

struct Event: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURIString: String?
    var urls: [URLObj]?
    var modified: Date?
    var start: Date?
    var end: Date?
    var thumbnail: Image?
    var comics: ResourceList<Comic>?
    var stories: ResourceList<Story>?
    var series: ResourceList<Series>?
    var characters: ResourceList<Character>?
    var creators: ResourceList<Creator>?
    var resourceURI: URL? { return convertURL(urlString: resourceURIString) }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, urls, modified, start, end,
            thumbnail, comics, stories, series, characters, creators
        case resourceURIString = "resourceURI"
    }
}

struct Series: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var resourceURIString: String?
    var resourceURI: URL? { return convertURL(urlString: resourceURIString) }
    var urls: [URLObj]?
    var modified: Date?
    var startYear: Date?
    var endYear: Date?
    var rating: String?
    var thumbnail: Image?
    var comics: ResourceList<Comic>?
    var stories: ResourceList<Story>?
    var characters: ResourceList<Character>?
    var creators: ResourceList<Creator>?
    var events: ResourceList<Event>?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, urls, modified, startYear, endYear,
        thumbnail, comics, stories, events, characters, creators
        case resourceURIString = "resourceURI"
    }
}

struct Creator: Codable {
    var id:Int?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var suffix: String?
    var fullName: String?
    var modified: Date?
    var resourceURIString: String?
    var resourceURI: URL? { return convertURL(urlString: resourceURIString) }
    var urls: [URLObj]?
    var thumbnail: Image?
    var comics: ResourceList<Comic>?
    var stories: ResourceList<Story>?
    var characters: ResourceList<Character>?
    var creators: ResourceList<Creator>?
    var events: ResourceList<Event>?
    var series: ResourceList<Series>?
    
    private enum CodingKeys: String, CodingKey {
        case id, firstName, middleName, urls, modified, suffix, fullName,
        thumbnail, comics, stories, events, characters, creators, series
        case resourceURIString = "resourceURI"
    }
}
