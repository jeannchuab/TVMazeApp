//
//  EpisodesListView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct EpisodesListView: View {
    var tvShowModel = MockData.tvShow1
    var seasonModel = MockData.season1
    @StateObject var viewModel = EpisodesViewModel()
    
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
                            .padding([.trailing, .leading])
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
            if viewModel.episodesModel.isEmpty {
                viewModel.getEpisodes(idSeason: seasonModel.id)
            }
        }
    }
}

#Preview {
    EpisodesListView()
}
