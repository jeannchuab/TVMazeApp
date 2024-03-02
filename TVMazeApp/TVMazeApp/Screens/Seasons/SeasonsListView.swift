//
//  SeasonsEpisodesView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct SeasonsListView: View {
    
    var tvShowModel = MockData.tvShow1
    @EnvironmentObject var viewModel: TVShowViewModel
    
    var body: some View {
        ZStack {
            
            BackgroundView()
            
            ScrollView {
                VStack {
                    Divider()
                    
                    ForEach(viewModel.seasonsModel) { season in
                        NavigationLink(destination: EpisodesListView(tvShowModel: tvShowModel, seasonModel: season)) {                              
                            Text(season.title)
                                .fontWeight(.semibold)
                                .padding()
                        }
                        
                        Divider()
                    }
                }
                .padding(.top)
            }
            .navigationTitle(tvShowModel.name)
            .navigationBarTitleDisplayMode(.inline)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            if viewModel.seasonsModel.isEmpty {
                viewModel.getSeasons(idTVShow: tvShowModel.id)
            }
        }
    }
}

#Preview {
    SeasonsListView()
}
