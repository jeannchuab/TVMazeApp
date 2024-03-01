//
//  TVShowCellView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct TVShowCellView: View {
    
    var tvShowModel: TVShowModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationLink(destination: TVShowDetailView(tvShowModel: tvShowModel,
                                                     isFavorite: favoriteViewModel.isFavorite(tvShowModel))) {
            
            VStack {
                
                Spacer()
                
                ZStack {
                    CustomRemoteImage(urlString: tvShowModel.image?.medium ?? "")
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }
                
                Text(tvShowModel.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .minimumScaleFactor(0.7)
                    .padding([.trailing, .leading])
                    .padding(.top, 4)
                
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    TVShowCellView(tvShowModel: SampleData.tvShow1)
}
