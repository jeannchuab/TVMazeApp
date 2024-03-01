//
//  TVMazeTabView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct TVMazeTabView: View {            
    
    @StateObject var favoritesViewModel = FavoriteViewModel()
    
    var body: some View {
        TabView {
            TVShowListView()
                .tabItem {
                    //We can use a Text and Image
                    //Image(systemName: "house")
                    //Text("Home")
                    
                    //Or a label
                    Label("Home", systemImage: "house")
                }
            
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            PeopleSearchView()
                .tabItem {
                    Label("People search", systemImage: "person")
                }
        }
        .environmentObject(favoritesViewModel)
    }
}

#Preview {
    TVMazeTabView()
}

