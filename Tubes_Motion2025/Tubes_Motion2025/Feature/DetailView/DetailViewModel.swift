//
//  DetailViewModel.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 01/03/25.
//

import Foundation
final class DetailViewModel: ObservableObject {
    private let repository: RecipeRepository
    private var recipe: Recipes

    init(recipe: Recipes, repository: RecipeRepository) {
        self.recipe = recipe
        self.repository = repository
    }

    func deleteRecipe(id: UUID) {
        Task {
            _ = repository.deleteRecipe(id: id)
        }
    }
}
