//
//  FavoriteEmptyListView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

struct FavoriteEmptyListView: View {
    
    let message: String = "It looks like your favorite TV series list is empty! Start adding your top picks now to keep track of all your must-watch shows in one place.\n\nHappy watching!"
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("⭐️🎬")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
                
                Text("🍿")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
            }
            .offset(y: -50)
        }
    }
}

#Preview {
    FavoriteEmptyListView()
}
