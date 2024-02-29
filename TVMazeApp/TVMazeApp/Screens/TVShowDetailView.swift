//
//  TVShowDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowDetailView: View {
    var tvShowModel = SampleData.tvShow1
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
                    
                    NavigationLink(destination: SeasonsListView(tvShowModel: tvShowModel)) {
                        Text("Seasons and Episodes")
                            .fontWeight(.semibold)
                            .padding()
                    }
                }
            }
            .navigationTitle(tvShowModel.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TVShowDetailView()
}
