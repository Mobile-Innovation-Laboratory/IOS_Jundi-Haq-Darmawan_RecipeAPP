//
//  ContentView.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 23/02/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewmodel = ContentViewModel()
    @State private var selectedRecipe: Recipes? = nil
    @State var isPresented: Bool = true
    @State private var isShowingUpdateRecipe = false

    var body: some View {
        NavigationView {
            VStack {
                if viewmodel.recipes.isEmpty {
                    Text("No Recipes Available")
                        .font(.title)
                        .padding()
                }
                List(viewmodel.recipes, id: \..id) { recipe in
                    NavigationLink(destination: DetailView(recipe: recipe, viewModel: DetailViewModel())) {
                        VStack(alignment: .leading) {
                            Text(recipe.name ?? "")
                                .font(.headline)
                            Text("Rating: \(recipe.rating ?? 0.0, specifier: "%.1f")")
                                .font(.subheadline)
                        }

                                                    Button("Edit") {
                                                        selectedRecipe = recipe
                                                        isShowingUpdateRecipe = true
                                                    }
                                                    .tint(.blue)
                                                }
                                            }
                                        }
                                    }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewmodel.isShowModal = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Get") {
                        Task {
                            await viewmodel.getRecipes()
                        }
                    }
                }
            }
            .sheet(isPresented: $viewmodel.isShowModal) {
                AddRecipeView
            }
            .alert("Success", isPresented: $viewmodel.isSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Recipe added successfully")
            }
            .alert("Error", isPresented: $viewmodel.isError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewmodel.errorText)
            }
        }
    }
extension ContentView{
    @ViewBuilder
    var AddRecipeView: some View {
            Form {
                TextField("Recipe Name", text: $viewmodel.nameText)
                TextField("Rating", value: $viewmodel.rating, formatter: NumberFormatter())
                TextField("Meal Type (comma separated)", text: $viewmodel.mealtypeText)
                TextField("Tag (comma separated)", text: $viewmodel.tagText)
                
                Button("Add Recipe") {
                    Task {
                        await viewmodel.createRecipe()
                        if viewmodel.isSuccess {
                            isPresented = false
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
}

#Preview {
    ContentView()
}

