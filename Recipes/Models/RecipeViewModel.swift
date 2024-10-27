//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import Foundation
import SwiftUI

@MainActor final class RecipeViewModel: ObservableObject {
    
    let recipesUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    @Published var recipes: [Recipe] = []
    @Published var loading: Bool = false
    @Published var netWorkError: NetworkError?
    @Published var hasAlert: Bool = false
    @Published var sortByName: Bool = true
    
    private func sortRecipes() {
        if sortByName {
            recipes.sort { $0.name < $1.name }
        } else {
            recipes.sort { $0.cuisine < $1.cuisine }
        }
    }
    
    func toggleSortOption() {
        sortByName.toggle()
        sortRecipes()
    }

    func downloadRecipes() {
        loading = true
        hasAlert = false
        Task {
            do {
                recipes = try await NetworkManager.shared.getRecipes(urlString: recipesUrlString)
                sortRecipes()
                loading = false
            } catch {
                if let returnedError = error as? NetworkError {
                    netWorkError = returnedError
                }
                loading = false
                hasAlert = true
            }
        }
    }
}

