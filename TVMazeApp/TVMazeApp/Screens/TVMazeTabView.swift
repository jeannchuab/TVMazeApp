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
    @StateObject var accountViewModel = AccountViewModel()
    
    var body: some View {
        
        ZStack {
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
            .onAppear {
                accountViewModel.retrieveUser()
            }
            .disabled(accountViewModel.isShowingPasswordView)
            .blur(radius: accountViewModel.isShowingPasswordView ? 20 : 0)
            
            if accountViewModel.isShowingPasswordView {
                PasswordView()
            }
        }
        .environmentObject(favoritesViewModel)
        .environmentObject(personViewModel)
        .environmentObject(tvShowViewModel)
        .environmentObject(accountViewModel)
    }
}

#Preview {
    TVMazeTabView()
}

