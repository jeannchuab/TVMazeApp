//
//  ContentView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowListView: View {
    
    @State private var isNight = false
    
    var columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var body: some View {        
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(SampleTVShowModel.list) { tvShowModel in
                            
                            NavigationLink(destination: TVShowDetailView(tvShowModel: SampleTVShowModel.mockTVShow1)) {
                                
                                VStack {
                                    //default image "movieclapper"
                                    Image("SampleImage")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fill)
                                    
                                    Text(tvShowModel.name)
                                        .font(.title3)
                                        .foregroundColor(Color(.label))
                                        .padding(.bottom, 8)
                                        .multilineTextAlignment(.center)
                                        .padding([.trailing, .leading])
                                        .scaledToFit()
                                    
                                    Text("Genre1, genre2, genre3")
                                        .font(.caption)
                                        .foregroundColor(Color(.label))
                                        .padding([.trailing, .leading, .bottom])
                                }
                                .cornerRadius(12)
                            }
                        }
                    }
                    .navigationBarTitle("🎬 TV Maze", displayMode: .large)
                }
                .padding()
            }
        }
    }
}

#Preview {
    TVShowListView()
}
