//
//  BackgroundView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        
        //TODO: Move to assets
        let topColor = Color.init(cgColor: CGColor(red: 213/255, green: 240/255, blue: 193/255, alpha: 1))
        let middleColor = Color.init(cgColor: CGColor(red: 249/255, green: 247/255, blue: 201/255, alpha: 1))
        let bottomColor = Color.white
                
        LinearGradient(gradient: Gradient(colors: [topColor, middleColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}
