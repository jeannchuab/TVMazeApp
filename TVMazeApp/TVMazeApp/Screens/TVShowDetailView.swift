//
//  TVShowDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowDetailView: View {
    
    var tvShowModel = SampleTVShowModel.TVShow1
    @State var isShowingSeasonsEpisodes = false
    
    var body: some View {
        ZStack {            
            BackgroundView()
            
            ScrollView {
                VStack {
                    ZStack {                                                
                        CustomRemoteImage(urlString: tvShowModel.image?.original ?? "")
                            .scaledToFit()
                            .frame(height: 400)
                            .cornerRadius(12)
                    }
                                                            
                    Text(tvShowModel.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                    
                    Text(tvShowModel.genres.joined(separator: ", "))
                        .font(.subheadline)
                        .padding([.trailing, .leading, .bottom])
                                        
                    Divider()
                        .foregroundColor(.accentColor)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(tvShowModel.premieredFormatted)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .padding([.trailing, .leading, .bottom])
                        
                        Spacer()
                    }
                                                            
                    VStack(alignment: .leading) {
                        Text(tvShowModel.summary?.removeHtmlTags() ?? "")
                            .padding([.trailing, .leading, .bottom])
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Text("Seasons and Episodes")
                            .padding()
                    }
                    
                    
                    
                    
//                    NavigationLink(destination: Text("Destination_2"), tag: 1, selection: $isShowingSeasonsEpisodes) {
//                        EmptyView()
//                    }
                }
            }
        }
    }
}

#Preview {
    TVShowDetailView()
}
