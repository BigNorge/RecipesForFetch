//
//  RecipeCell.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import SwiftUI

struct RecipeCell: View {
    
    @Environment(\.openURL) var openURL
    @State var recipe: Recipe

    var body: some View {
        HStack {
            if let photoUrlSmall = recipe.photo_url_small {
                RecipeImage(urlString: photoUrlSmall)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
            } else {
                Image("recipePlaceholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(recipe.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Text(recipe.cuisine)
                        .font(.title3)
                    Spacer()
                    if let sourceUrl = URL(string: recipe.source_url ?? "") {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                openURL(sourceUrl)
                            }
                            .padding(.leading)
                    }
                    if let youTubeUrl =  URL(string: recipe.youtube_url ?? "") {
                        Image("youTubeImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                openURL(youTubeUrl)
                            }
                            .padding(.leading)
                    }
                }
                .frame(height: 40)
            }
        }
        .padding()
    }
}

#Preview {
    RecipeCell(recipe: MockRecipe.sample)
}
