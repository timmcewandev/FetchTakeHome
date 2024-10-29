//
//  ContentView.swift
//  Fetch
//
//  Created by Tim McEwan on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipes] = []

    var body: some View {
        NavigationView {
            List(recipes, id: \.uuid) { recipe in
                
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: recipe.photoUrlSmall ?? "photo")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .font(.title)
                                    .padding()
                            } else {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)
                            Text(recipe.cuisine)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                
            }
            .navigationTitle("Recipes")
        }
        .onAppear {
            appMine()
        }
    }

    func appMine() {
        Task {
            let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
            guard let myURL = URL(string: url) else { return }
            let request = URLRequest(url: myURL)
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
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

