//
//  RemoteImageView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    func load(fromURLString urlString: String) {
        
        self.image = Image("movieclapper").resizable()
                        
        Task {
            let uiImage = try await NetworkManager.shared.downloadImageAsync(fromURLString: urlString)
            self.image = Image(uiImage: uiImage)
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    var body: some View {                        
        image?.resizable() ?? Image(systemName: "movieclapper").resizable()
    }
}

struct CustomRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    
    let urlString: String
    var body: some View {
        
        if urlString.isEmpty {
            Image(systemName: "movieclapper").resizable()
        } else {
            ZStack {
                LoadingView()
                
                RemoteImage(image: imageLoader.image)
                    .onAppear {
                        imageLoader.load(fromURLString: urlString)
                    }
            }
        }
    }
}

