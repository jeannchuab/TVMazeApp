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
//            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
//            }
        }
        
        
        
//        NetworkManager.shared.downloadImage(fromURLString: uriString) { uiImage in
//            guard let uiImage else { return }
//            DispatchQueue.main.async {
//                self.image = Image (uiImage: uiImage)
//            }
//        }
    }
}

struct RemoteImage: View {
    var image: Image?
    var body: some View {
                        
        image?.resizable() ?? Image("movieclapper").resizable()
    }
}

struct CustomRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    
    let urlString: String
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}

