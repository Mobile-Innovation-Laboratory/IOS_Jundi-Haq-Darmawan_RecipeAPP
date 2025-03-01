//
//  ContentViewModel.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    private let recipeRepository: RecipeRepository = RecipeRepository()

    @Published var recipes: [Recipes] = []
    @Published var searchText = ""
    @Published var nameText = ""
    @Published var rating = 0.0
    @Published var mealtypeText = ""
    @Published var tagText = ""
    @Published var isSuccess = false
    @Published var isError = false
    @Published var errorText = ""
    @Published var isShowModal = false
    
    @MainActor
    func createRecipe() async {
        let mealtype = mealtypeText.components(separatedBy: ",")
        let tag = tagText.components(separatedBy: ",")
        let response = recipeRepository.createRecipe(name: nameText, rating: rating, mealtype: mealtype, tag: tag)

        switch response {
        case .success(let success):
            isShowModal = false
            isSuccess = success
            await getRecipes()
        case .failure(let failure):
            print("Error: \(failure)")
        }
    }

    @MainActor
    func getRecipes() async {
        let response = recipeRepository.getRecipes(searchText: searchText)

        switch response {
        case .success(let success):
            recipes = success
        case .failure(let failure):
            print("Error: \(failure)")
        }
    }

    @MainActor
    func updateRecipe(id: UUID) async {
        let mealtype = mealtypeText.components(separatedBy: ",")
        let tag = tagText.components(separatedBy: ",")
        let response = recipeRepository.updateRecipe(id: id, name: nameText, rating: rating, mealtype: mealtype, tag: tag)

        switch response {
        case .success(let success):
            isShowModal = false
            isSuccess = success
            await getRecipes()
        case .failure(let failure):
            print("Error: \(failure)")
        }
    }

    @MainActor
    func deleteRecipe(id: UUID) async {
        let response = recipeRepository.deleteRecipe(id: id)

        switch response {
        case .success(let success):
            isSuccess = success
            await getRecipes()
        case .failure(let failure):
            print("Error: \(failure)")
        }
    }
}

