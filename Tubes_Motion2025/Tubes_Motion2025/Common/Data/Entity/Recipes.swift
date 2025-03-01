//
//  Recipes.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//

import Foundation

struct RecipesListResponse: Codable {
    var recipes: [RecipesResponse]?
    var total: Int?
    var skip: Int?
    var limit: Int?
}

struct RecipesResponse: Codable {
    var id: Int?
    var name: String?
    var ingredients: [String]?
    var instructions: [String]?
    var prepTimeMinutes: Int?
    var cookTimeMinutes: Int?
    var servings: Int?
    var difficulty: String?
    var cuisine: String?
    var caloriesPerServing: Int?
    var tags: [String]?
    var userId: Int?
    var image: String?
    var rating: Double?
    var reviewCount: Int?
    var mealType: [String]?
}
struct AddRecipes: Codable{
    var id: Int?
    var name: String?
}
struct deleterecipe: Codable{
    var id: Int?
    var isDeleted: Bool?
}
struct Recipes: Identifiable{
    var id: UUID? = UUID()
    var name: String? = ""
    var mealtype: [String]? = []
    var tag: [String]? = []
    var rating: Double? = 0.0
}

