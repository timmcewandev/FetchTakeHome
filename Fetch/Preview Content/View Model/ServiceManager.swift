//
//  ServiceManager.swift
//  Fetch
//
//  Created by Tim McEwan on 10/29/24.
//

import Foundation
import SwiftUI

class ServiceManager: ObservableObject {
    @Published var recipes: [Recipes] = []
    @Published var isOnError = false
    
    init()  {
        Task {
            await getRecipes()
        }
    }

        func getRecipes() async {
            Task {
//                let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
                let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
                guard let myURL = URL(string: url) else { return }
                let request = URLRequest(url: myURL)
                
                do {
                    let (data, _) = try await URLSession.shared.data(for: request)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let gitData = try decoder.decode(RecipeResponse.self, from: data)
                    await MainActor.run {
                        recipes = gitData.recipes
                    }
                } catch {
                    self.isOnError.toggle()
                }
            }
    }
    
}
