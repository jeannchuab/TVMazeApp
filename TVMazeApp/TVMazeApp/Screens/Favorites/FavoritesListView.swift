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
                    
                    //TODO: Implement pagination
                                                            
                    LazyVGrid(columns: viewModel.columns) {
                                                                        
                        ForEach(viewModel.favoritesTvShows) { tvShowModel in
                            TVShowCellView(tvShowModel: tvShowModel)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Type your search here")
                    .onSubmit(of: .search) {
                        print(".onSubmit(of: .search)")
                        runSearch()
                    }
                    .navigationTitle("⭐️ Favorites")
//                    .navigationBarTitleDisplayMode(.inline)
                    
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView()
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
