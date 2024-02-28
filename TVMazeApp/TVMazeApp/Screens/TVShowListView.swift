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
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(viewModel.tvShowsModel) { tvShowModel in
                            TVShowCellView(tvShowModel: tvShowModel)
                        }
                    }
                    .navigationBarTitle("🎬 TV Maze")
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .task {
                viewModel.getTVShows()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    TVShowListView()
}
