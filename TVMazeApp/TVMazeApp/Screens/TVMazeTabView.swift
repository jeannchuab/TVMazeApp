//
//  TVMazeTabView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct TVMazeTabView: View {            
    
    @StateObject var favoritesViewModel = FavoriteViewModel()
    @StateObject var personViewModel = PersonViewModel()
    
    var body: some View {
        TabView {
            TVShowListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            PeopleListView()
                .tabItem {
                    Label("People search", systemImage: "person")
                }
        }
        .environmentObject(favoritesViewModel)
        .environmentObject(personViewModel)
    }
}

#Preview {
    TVMazeTabView()
}

