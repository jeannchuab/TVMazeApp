//
//  TVMazeTabView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct TVMazeTabView: View {                
    @StateObject var tvShowViewModel = TVShowViewModel()
    @StateObject var favoritesViewModel = FavoriteViewModel()
    @StateObject var personViewModel = PersonListViewModel()
    
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
            
            PersonListView()
                .tabItem {
                    Label("People search", systemImage: "person")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "gear")
                }
        }
        .environmentObject(favoritesViewModel)
        .environmentObject(personViewModel)
        .environmentObject(tvShowViewModel)
    }
}

#Preview {
    TVMazeTabView()
}

