//
//  ContentView.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import SwiftUI

struct RecipeListView: View {

    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Recipes")
                    .font(.title)
                    .fontWeight(.semibold)
                HStack {
                    Text("Sorted by \(viewModel.sortByName ? "Name" : "Cuisine")")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Button {
                        viewModel.toggleSortOption()
                    } label: {
                        Text("Resort")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .disabled(viewModel.loading)
                }
                List(viewModel.recipes) { recipe in
                    RecipeCell(recipe: recipe)
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.downloadRecipes()
                }
                .disabled(viewModel.loading)
            }
            if viewModel.loading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(2)
            }
        }
        .alert(isPresented: $viewModel.hasAlert) {
            var alertTitle = ""
            switch viewModel.netWorkError {
            case .invalidURL:
                alertTitle = "The URL was invalid"
            case .dataDecoding:
                alertTitle = "The network response could not be used"
            case .none:
                alertTitle = "The recipes could not be retrieved for an unknown reason"
            }
            return Alert(title: Text(alertTitle), dismissButton: .default(Text("OK")))
        }
        .onAppear() {
             viewModel.downloadRecipes()
        }
    }
}

#Preview {
    RecipeListView()
}
