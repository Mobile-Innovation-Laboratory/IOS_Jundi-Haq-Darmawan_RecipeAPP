//
//  ProductTargetType.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//
import Foundation
import Moya

enum RecipesTargetType {
    case getRecipes
    case getRecipesbyTag([String])
    case getRecipesByMealType([String])
    case AddRecipe(AddRecipes)
    case UpdateRecipes(Int,AddRecipes)
    case deleteRecipes(Int)

    
}

extension RecipesTargetType: DefaultTargetType, AccessTokenAuthorizable {
    
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            "/recipes"
        case .getRecipesbyTag(let tag):
            "/recipes/tag/\(tag)"
        case .getRecipesByMealType(let mealtype):
            "/recipes/meal-type\(mealtype)"
        case .AddRecipe:
            "/recipes/add"
        case .UpdateRecipes(let id,_):
            "/recipes/\(id)"
        case .deleteRecipes(let id):
            "/recipes/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecipes:
            return .get
        case .getRecipesbyTag:
            return .get
        case .getRecipesByMealType:
            return .get
        case .AddRecipe:
            return .post
        case .UpdateRecipes:
            return .put
        case .deleteRecipes:
            return .delete
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .AddRecipe(let recipes):
            return recipes.toJson()
        case .UpdateRecipes(_, let recipes):
            return recipes.toJson()
        case .getRecipesbyTag(let tag):
            return["tag": tag]
        case .getRecipesByMealType(let mealtype):
            return["mealtype": mealtype]
        default:
            return [:]
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .AddRecipe, .UpdateRecipes:
            return JSONEncoding.default
        default: return URLEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
