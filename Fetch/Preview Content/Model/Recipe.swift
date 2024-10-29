//
//  Recipe.swift
//  Fetch
//
//  Created by Tim McEwan on 10/28/24.
//

import Foundation

struct Recipes: Codable, Identifiable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    var id: String { uuid }
    
    enum CodingKeys: String, CodingKey {

        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
        case uuid, name, cuisine
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipes]
}


