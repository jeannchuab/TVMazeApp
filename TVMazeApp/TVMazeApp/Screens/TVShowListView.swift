//
//  ContentView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowListView: View {
    @StateObject var viewModel = TVShowViewModel()
    
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
                        runSearch()
                    }
                    .navigationTitle("🎬 TV Maze")
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
            viewModel.getTVShows(searchQuery: viewModel.searchText)
        }
    }
}

#Preview {
    TVShowListView()
}
