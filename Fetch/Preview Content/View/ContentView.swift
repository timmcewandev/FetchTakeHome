//
//  ContentView.swift
//  Fetch
//
//  Created by Tim McEwan on 10/28/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var recipes: [Recipes] = []

    var body: some View {
        NavigationView {
            List(recipes, id: \.uuid) { recipe in
                
                HStack {
                    if let url = URL(string: recipe.photoUrlSmall ?? "hello") {
                        KFImage(url)
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                            .shadow(radius: 10)
                            .frame(width: 100, height: 100)
                            .padding(20)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                            .fontWidth(.compressed)
                        Text(recipe.cuisine)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                }
                
            }
            
            .navigationTitle("Recipes")
        }
        .onAppear {
            Task {
                await getRecipes()
            }
            
        }
    }
    
    func getRecipes() async {
        Task {
            let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
            guard let myURL = URL(string: url) else { return }
            let request = URLRequest(url: myURL)
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let gitData = try decoder.decode(RecipeResponse.self, from: data)
                await MainActor.run {
                    self.recipes = gitData.recipes
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

