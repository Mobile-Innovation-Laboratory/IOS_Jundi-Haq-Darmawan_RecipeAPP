//
//  RecipeRepository.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//
import CoreData
import Foundation
import Moya


final class RecipeRepository{
    
    private let viewContext: NSManagedObjectContext
    private let provider: MoyaProvider<RecipesTargetType>
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext, provider: MoyaProvider<RecipesTargetType> = .defaultProvider()) {
        self.viewContext = viewContext
        self.provider = provider
    }
    func createRecipe(name: String, rating: Double, mealtype: [String], tag: [String]) -> Result<Bool, Error> {
            let entity = RecipeEntity(context: viewContext)
            entity.id = UUID()
            entity.name = name
        entity.mealtype = mealtype.joined(separator: ",")
            entity.rating = rating
        entity.tag = tag.joined(separator: ",")
            
            do {
                try viewContext.save()
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        
        func updateRecipe(id: UUID, name: String, rating: Double, mealtype: [String], tag: [String]) -> Result<Bool, Error> {
            let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                if let entity = results.first {
                    entity.name = name
                    entity.rating = rating
                    entity.mealtype = mealtype.joined(separator: ",")
                    entity.tag = tag.joined(separator: ",")
                    try viewContext.save()
                    return .success(true)
                } else {
                    return .failure(NSError(domain: "Recipe not found", code: 404, userInfo: nil))
                }
            } catch {
                return .failure(error)
            }
        }
        
        func deleteRecipe(id: UUID) -> Result<Bool, Error> {
            let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                if let entity = results.first {
                    viewContext.delete(entity)
                    try viewContext.save()
                    return .success(true)
                } else {
                    return .failure(NSError(domain: "Recipe not found", code: 404, userInfo: nil))
                }
            } catch {
                return .failure(error)
            }
        }
        
        func getRecipes(searchText: String? = nil) -> Result<[Recipes], Error> {
            let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
            
            if let searchText, !searchText.isEmpty {
                let predicate = NSPredicate(format: "(name CONTAINS[cd] %@) OR (mealtype CONTAINS[cd] %@) OR (tag CONTAINS[cd] %@)", searchText, searchText, searchText)
                fetchRequest.predicate = predicate
            }
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                let response = results.map { entity in
                    Recipes(id: entity.id, name: entity.name, mealtype: entity.mealtype?.components(separatedBy: ",") ?? [], tag: entity.tag?.components(separatedBy: ",") ?? [], rating: entity.rating)
                }
                return .success(response)
            } catch {
                return .failure(error)
            }
        }
    func getRecipes() async -> Result<RecipesListResponse, Error>{
        do {
            let response = try await provider.requestAsync(.getRecipes, model: RecipesListResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    func getRecipesbyTag(tag: [String]) async -> Result<RecipesResponse, Error>{
        do {
            let response = try await provider.requestAsync(.getRecipesbyTag(tag), model: RecipesResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    func getRecipesByMealType(mealtype:[String]) async -> Result<RecipesResponse, Error>{
        do {
            let response = try await provider.requestAsync(.getRecipesByMealType(mealtype), model: RecipesResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    func AddRecipe(post:AddRecipes) async -> Result<AddRecipes, Error>{
        do {
            let response = try await provider.requestAsync(.AddRecipe(post), model: AddRecipes.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    func UpdateRecipes(id:Int,put:AddRecipes) async -> Result<AddRecipes, Error>{
        do {
            let response = try await provider.requestAsync(.UpdateRecipes(id, put), model: AddRecipes.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    func deleteRecipes(id: Int) async -> Result<deleterecipe, Error>{
        do {
            let response = try await provider.requestAsync(.deleteRecipes(id), model: deleterecipe.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
