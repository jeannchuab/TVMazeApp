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
    
    @State var isShowingPasswordView = false
    
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
                checkPasswordRequired()
            }
            .disabled(isShowingPasswordView)
            .blur(radius: isShowingPasswordView ? 20 : 0)
            
            if isShowingPasswordView {
                PasswordView(isShowing: $isShowingPasswordView)
            }
        }
        .environmentObject(favoritesViewModel)
        .environmentObject(personViewModel)
        .environmentObject(tvShowViewModel)
        .environmentObject(accountViewModel)
    }
    
    func checkPasswordRequired() {
        accountViewModel.retrieveUser()
        isShowingPasswordView = accountViewModel.userModel.isPasswordRequiredLaunch
        print("UserModel: ", accountViewModel.userModel)
    }
}

#Preview {
    TVMazeTabView()
}

