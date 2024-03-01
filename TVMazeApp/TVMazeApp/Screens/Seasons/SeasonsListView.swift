//
//  SeasonsEpisodesView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct SeasonsListView: View {
    
    var tvShowModel = SampleData.tvShow1
    @EnvironmentObject var viewModel: TVShowViewModel
    
    var body: some View {
        ZStack {
            
            BackgroundView()
            
            ScrollView {
                VStack {
                    Divider()
                    
                    ForEach(viewModel.seasonsModel) { season in
                        NavigationLink(destination: EpisodesListView(tvShowModel: tvShowModel, seasonModel: season)) {
  
                            //TODO: Improvement
//                            CustomRemoteImage(urlString: season.image?.original ?? "")
//                                .scaledToFit()
//                                .aspectRatio(contentMode: .fit)
//                                .cornerRadius(12)
//                                .frame(width: 80, height: 80)
//                                .padding()
                            
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
        .task {            
            viewModel.getSeasons(idTVShow: tvShowModel.id)
        }
    }
}

#Preview {
    SeasonsListView()
}
