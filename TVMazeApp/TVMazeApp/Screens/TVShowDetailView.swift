//
//  TVShowDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowDetailView: View {
    
    var tvShowModel = SampleTVShowModel.mockTVShow1
    var isNight = false
    
    var body: some View {
        ZStack {            
            BackgroundView()
            
            ScrollView {
                VStack {
                                
                    //default image "movieclapper"
                    
                    Image("SampleImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .cornerRadius(12)
                    
                    Text(tvShowModel.name)
                        .font(.title2)
                        .padding(.bottom, 8)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                    
                    Text("Genre1, genre2, genre3")
                        .font(.subheadline)
                        .padding([.trailing, .leading, .bottom])
                    
                    //TODO: Format date
                    
                    Divider()
                        .foregroundColor(.accentColor)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("Premiered at \(tvShowModel.premiered), \(tvShowModel.schedule.time)h")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .padding([.trailing, .leading, .bottom])
                        
                        Spacer()
                    }
                    
                    Text(tvShowModel.summary)
                        .padding([.trailing, .leading, .bottom])
                    
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
