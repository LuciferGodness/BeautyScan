//
//  SearchProductDTO.swift
//  BeautyScan
//
//  Created by admin on 22.11.2023.
//

import Foundation

struct SearchProductDTO: Decodable {
    let items: [Item]?
    let queries: Queries
    
    private enum CodingKeys: String, CodingKey {
        case items
        case queries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([Item].self, forKey: .items)
        self.queries = try container.decode(Queries.self, forKey: .queries)
    }
}

struct Queries: Decodable {
    let request: [Request]
    
    private enum CodingKeys: String, CodingKey {
        case request
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.request = try container.decode([Request].self, forKey: .request)
    }
}

struct Request: Decodable {
    let searchTerms: String
    
    private enum CodingKeys: String, CodingKey {
        case searchTerms
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.searchTerms = try container.decode(String.self, forKey: .searchTerms)
    }
}

struct Item: Decodable {
    let title: String 
    let link: String 
    let displayLink: String
    let formattedUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case displayLink
        case formattedUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decode(String.self, forKey: .link)
        self.displayLink = try container.decode(String.self, forKey: .displayLink)
        self.formattedUrl = try container.decode(String.self, forKey: .formattedUrl)
    }
}
