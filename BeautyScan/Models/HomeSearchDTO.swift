//
//  HomeSearchDTO.swift
//  BeautyScan
//
//  Created by admin on 04.03.2024.
//

import Foundation

struct HomeSearchDTO: Decodable {
    let products: [ProductSearch]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var productsArray = [ProductSearch]()
        
        while !container.isAtEnd {
            let product = try container.decode(ProductSearch.self)
            productsArray.append(product)
        }
        
        products = productsArray
    }
}

struct ProductSearch: Decodable {
    let brand: String
    let name: String
    let price: String
    let priceSign: String?
    let currency: String?
    let imageLink: String
    let productLink: String
    let websiteLink: String
    let description: String
    let rating: Double?
    let category: String?
    let productType: String
    let productApiURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, brand, name, price
        case priceSign = "price_sign"
        case currency, imageLink = "image_link"
        case productLink = "product_link"
        case websiteLink = "website_link"
        case description, rating, category
        case productType = "product_type"
        case tagList = "tag_list"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case productApiURL = "product_api_url"
        case apiFeaturedImage = "api_featured_image"
        case productColors = "product_colors"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        brand = try values.decode(String.self, forKey: .brand)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(String.self, forKey: .price)
        priceSign = try values.decodeIfPresent(String.self, forKey: .priceSign)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        imageLink = try values.decode(String.self, forKey: .imageLink)
        productLink = try values.decode(String.self, forKey: .productLink)
        websiteLink = try values.decode(String.self, forKey: .websiteLink)
        description = try values.decode(String.self, forKey: .description)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        productType = try values.decode(String.self, forKey: .productType)
        productApiURL = try values.decode(String.self, forKey: .productApiURL)
    }
}
