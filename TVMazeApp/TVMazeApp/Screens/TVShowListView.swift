//
//  ContentView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowListView: View {
    
    @StateObject var viewModel = TVShowViewModel()
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    
                    //TODO: Implement pagination
                                                            
                    LazyVGrid(columns: viewModel.columns) {
                                                                        
                        ForEach(viewModel.tvShowsModel) { tvShowModel in
                            TVShowCellView(tvShowModel: tvShowModel)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Type your search here")                                           
                    .onSubmit(of: .search) {
                        print(".onSubmit(of: .search)")
                        viewModel.getTVShows(searchQuery: viewModel.searchText)
                    }
                    .navigationBarTitle("🎬 TV Maze")
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .onAppear() {
                print(".onAppear")
                viewModel.getTVShows(searchQuery: viewModel.searchText)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    
    func runSearch() {
        Task {
            viewModel.getTVShows(searchQuery: viewModel.searchText)
        }
    }
}

#Preview {
    TVShowListView()
}
