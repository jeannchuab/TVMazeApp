//
//  LoadingView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.clear)
                .ignoresSafeArea(edges: .all)
                        
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .controlSize(.large)
        }
    }
}


#Preview {
    LoadingView()
}
