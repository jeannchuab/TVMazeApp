//
//  ContentView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct ContentView: View {
    
    var columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    var body: some View {
        VStack {
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    
                    ForEach(SampleTVShowModel.list) { tvShowModel in
                        VStack {
                            Image(systemName: "movieclapper")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            Text(tvShowModel.name)
                                .font(.title3)
                                .padding(.bottom, 8)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)                                
                            
                            Text("Genre1, genre2, genre3")
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
