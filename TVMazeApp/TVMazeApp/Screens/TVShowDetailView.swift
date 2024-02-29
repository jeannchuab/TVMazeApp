//
//  TVShowDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowDetailView: View {
    
    var tvShowModel = SampleTVShowModel.TVShow1
    var isNight = false
    
    var body: some View {
        ZStack {            
            BackgroundView()
            
            ScrollView {
                VStack {
                    ZStack {
//                        LoadingView()
                                                
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
                        
                        //TODO: Move to viewModel
                        
//                        Text("Premiered at \(tvShowModel.premiered?.formattedDate()), \(tvShowModel.schedule?.time)h")
//                            .font(.subheadline)
//                            .multilineTextAlignment(.leading)
//                            .padding([.trailing, .leading, .bottom])
                        
                        Spacer()
                    }
                                                            
                    VStack(alignment: .leading) {
                        Text(tvShowModel.summary?.removeHtmlTags() ?? "")
                            .padding([.trailing, .leading, .bottom])
                    }
                    
                    Button {
                        print("Seasons and Episodes")
                    } label: {
                        Text("Seasons and Episodes")
                    }
                    .padding()
                    
                    
                }
            }
        }
    }
}

#Preview {
    TVShowDetailView()
}
