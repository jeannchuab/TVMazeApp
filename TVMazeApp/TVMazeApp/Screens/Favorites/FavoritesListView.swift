//
//  FavoritesListView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var viewModel: FavoriteViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns) {
                                                                        
                        ForEach(viewModel.favoritesTvShowsSearched) { tvShowModel in
                            TVShowCellView(tvShowModel: tvShowModel)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Type your search here")
                    .onSubmit(of: .search) {                        
                        runSearch()
                    }
                    .navigationTitle("⭐️ Favorites")                   
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView()
                }
                
                if viewModel.favoritesTvShows.isEmpty {
                    FavoriteEmptyListView()
                }
            }
            .onAppear() {
                runSearch()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .environmentObject(viewModel)
    }
    
    func runSearch() {
        Task {
            viewModel.getFavorites(searchQuery: viewModel.searchText)
        }
    }
}

#Preview {
    FavoritesListView()
}
