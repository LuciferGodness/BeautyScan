//
//  HomeDTO.swift
//  BeautyScan
//
//  Created by admin on 10.11.2023.
//

import Foundation

struct HomeDTO: Decodable {
    let status: String
    let hits: [Product]
}

struct Product: Decodable {
    //let id: Int
    let name: String
    let article: String
    let brand: Brand
    let cover: Cover
    let price: Price
    let votes: Votes
    let flagShowPrice: Bool
    let flagCanBuy: Bool
    let flagSupplierNoOrder: Bool
    
    private enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case article = "ARTICLE"
        case brand = "BRAND"
        case cover = "COVER"
        case price = "PRICE"
        case votes = "VOTES"
        case flagShowPrice = "FLAG_SHOW_PRICE"
        case flagCanBuy = "FLAG_CAN_BUY"
        case flagSupplierNoOrder = "FLAG_SUPPLIER_NO_ORDER"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        article = try values.decode(String.self, forKey: .article)
        brand = try values.decode(Brand.self, forKey: .brand)
        cover = try values.decode(Cover.self, forKey: .cover)
        price = try values.decode(Price.self, forKey: .price)
        votes = try values.decode(Votes.self, forKey: .votes)
        flagShowPrice = try values.decode(Bool.self, forKey: .flagShowPrice)
        flagCanBuy = try values.decode(Bool.self, forKey: .flagCanBuy)
        flagSupplierNoOrder = try values.decode(Bool.self, forKey: .flagSupplierNoOrder)
    }
}

struct Brand: Decodable {
    let id: Int
    let code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case code = "CODE"
        case name = "NAME"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        code = try values.decode(String.self, forKey: .code)
    }
}

struct Cover: Decodable {
    let src: String?
    let srcM: String?
    let srcS: String?
    
    enum CodingKeys: String, CodingKey {
        case src = "SRC"
        case srcM = "SRC_M"
        case srcS = "SRC_S"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        src = try values.decode(String.self, forKey: .src)
        srcM = try values.decode(String.self, forKey: .srcM)
        srcS = try values.decode(String.self, forKey: .srcS)
    }
}

struct Price: Decodable {
    let current: Int?
    let retail: Int?
    let professional: Int?
    let old: Int?
    
    enum CodingKeys: String, CodingKey {
        case current = "CURRENT"
        case retail = "RETAIL"
        case professional = "PROFESSIONAL"
        case old = "OLD"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        current = try values.decode(Int.self, forKey: .current)
        retail = try values.decode(Int.self, forKey: .retail)
        professional = try values.decode(Int.self, forKey: .professional)
        old = try values.decode(Int.self, forKey: .old)
    }
}

struct Votes: Decodable {
    let reviews: Int?
    let rating: Double?
    let ratingCount: Int?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case reviews = "REVIEWS"
        case rating = "RATING"
        case ratingCount = "RATING_COUNT"
        case text = "TEXT"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        reviews = try values.decode(Int.self, forKey: .reviews)
        rating = try values.decode(Double.self, forKey: .rating)
        ratingCount = try values.decode(Int.self, forKey: .ratingCount)
        text = try values.decode(String.self, forKey: .text)
    }
}
