//
//  SeasonsEpisodesView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct SeasonsEpisodesView: View {
    
    var tvShowModel = SampleTVShowModel.TVShow1
    @EnvironmentObject var viewModel: TVShowViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            List(viewModel.seasonsModel) { season in
                Text("Season \(season.number)")
            }
            .listStyle(.plain)
            .padding()
            .navigationTitle("Seasons")
        }
        .task {
            viewModel.getSeasons(idTVShow: tvShowModel.id)
        }
    }
}

#Preview {
    SeasonsEpisodesView()
}
