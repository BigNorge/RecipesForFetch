//
//  Recipe.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import SwiftUI

struct Recipes: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    var id: String = UUID().uuidString
    let uuid: String
    let cuisine: String
    let name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var source_url: String?
    var youtube_url: String?
    
    private enum CodingKeys: String, CodingKey {
        case uuid, cuisine, name, photo_url_large, photo_url_small, source_url, youtube_url
    }
}

struct MockRecipe {
    static let sample = Recipe(uuid: "abcd_1234",
                               cuisine: "French",
                               name: "Crepes Suzette",
                               photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                               source_url: "https://some.url/index.html",
                               youtube_url: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                               )
    
    static let sampleArray = [
        MockRecipe.sample,
        MockRecipe.sample,
        MockRecipe.sample,
        MockRecipe.sample,
    ]
}
