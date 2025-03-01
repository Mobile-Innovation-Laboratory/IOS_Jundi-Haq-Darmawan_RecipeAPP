//
//  DetailView.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 01/03/25.
//

import SwiftUI

struct DetailView: View {
    let recipe: Recipes
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name ?? "")
                .font(.largeTitle)
                .padding()

            Text("Rating: \(recipe.rating ?? 0.0)")
                .padding()

            Text("Meal Type: \(recipe.mealtype?.joined(separator: ", ") ?? "")")
                .padding()

            Text("Tags: \(recipe.tag?.joined(separator: ", ") ?? "")")
                .padding()

            Spacer()
        }
        .navigationTitle("Recipe Detail")
        .toolbar {
            Button("Delete") {
                viewModel.deleteRecipe(id: recipe.id!)
            }
        }
    }
}
#Preview {
    DetailView(recipe: Recipes(), viewModel: DetailViewModel(recipe: Recipes(), repository: RecipeRepository()))
}
