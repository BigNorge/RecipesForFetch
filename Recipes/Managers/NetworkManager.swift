//
//  NetworkManager.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import SwiftUI

class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getRecipes(urlString: String) async throws -> [Recipe] {
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let recipes = try decoder.decode(Recipes.self, from: data)
            return recipes.recipes
        } catch {
            throw NetworkError.dataDecoding
        }
    }
    
    func getImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
