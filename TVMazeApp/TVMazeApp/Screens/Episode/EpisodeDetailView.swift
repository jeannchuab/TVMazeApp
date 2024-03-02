//
//  EpisodeDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct EpisodeDetailView: View {
    var tvShowModel = MockData.tvShow1
    var episodeModel = MockData.episode1
        
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    ZStack {
                        CustomRemoteImage(urlString: episodeModel.image?.original ?? "")
                            .scaledToFit()
                            .frame(height: 400)
                            .cornerRadius(12)
                    }
                    
                    Text(episodeModel.seasonEpisodeTitleFormatted)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                                                            
                    Text("\(episodeModel.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .lineLimit(2, reservesSpace: false)
                        .scaledToFit()
                                                            
                    Divider()
                        .foregroundColor(.accentColor)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(episodeModel.airDateTimeFormatted)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .padding([.trailing, .leading, .bottom])
                        
                        Spacer()
                    }
                                                            
                    VStack(alignment: .leading) {
                        Text(episodeModel.summary?.removeHtmlTags() ?? "")
                            .padding([.trailing, .leading, .bottom])
                    }
                }
            }
            .navigationTitle(tvShowModel.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EpisodeDetailView()
}
