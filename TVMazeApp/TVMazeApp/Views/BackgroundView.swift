//
//  BackgroundView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.backgroundTop, 
                                                   Color.backgroundMiddle,
                                                   Color.backgroundBottom]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}
