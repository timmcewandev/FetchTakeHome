//
//  ContentView.swift
//  Fetch
//
//  Created by Tim McEwan on 10/28/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var serviceManager = ServiceManager()
    
    var body: some View {
        NavigationStack {
            if serviceManager.isOnError {
                Text("Loading error try again later")
            } else {
                List(serviceManager.recipes, id: \.uuid) { recipe in
                    HStack {
                        if let url = URL(string: recipe.photoUrlSmall ?? "") {
                            KFImage(url)
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                                .shadow(radius: 10)
                                .frame(width: 100, height: 100)
                                .padding(10)
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
                .refreshable {
                }
                .navigationTitle("Recipes")
            }
        }
    }
}

