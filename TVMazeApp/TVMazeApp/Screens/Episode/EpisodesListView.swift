//
//  EpisodesListView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct EpisodesListView: View {
    var tvShowModel = SampleData.tvShow1
    var seasonModel = SampleData.season1
    @EnvironmentObject var viewModel: TVShowViewModel
    
    var body: some View {
        ZStack {
            
            BackgroundView()
                                    
            ScrollView {
                VStack {
                    
                    Text("Season \(seasonModel.number)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                    
                    Divider()
                    
                    ForEach(viewModel.episodesModel) { episode in
                        NavigationLink(destination: EpisodeDetailView(tvShowModel: tvShowModel,
                                                                      episodeModel: episode)) {
                            
                            VStack(spacing: 12) {
                                Text(episode.title)
                                    .fontWeight(.semibold)
                                    .padding(.top)
                                
                                Text(episode.name)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                            }
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
        .task {
            viewModel.getEpisodes(idSeason: seasonModel.id)
        }
    }
}

#Preview {
    EpisodesListView()
}
