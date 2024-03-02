//
//  PersonDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

struct PersonDetailView: View {
    var personModel = SampleData.person1
//    @EnvironmentObject var viewModel: PersonViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    ZStack {
                        CustomRemoteImage(urlString: personModel.image?.original ?? "")
                            .scaledToFit()
                            .frame(height: 400)
                            .cornerRadius(12)
                    }
                                                            
                    Text(personModel.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                    
//                    Text(tvShowModel.genres.joined(separator: ", "))
//                        .font(.subheadline)
//                        .padding([.trailing, .leading, .bottom])
                                        
                    Divider()
                        .foregroundColor(.accentColor)
                    
//                    HStack(alignment: .firstTextBaseline) {
//                        Text(tvShowModel.premieredFormatted)
//                            .font(.subheadline)
//                            .multilineTextAlignment(.leading)
//                            .padding([.trailing, .leading, .bottom])
//                        
//                        Spacer()
//                    }
                                                            
//                    VStack(alignment: .leading) {
//                        Text(tvShowModel.summary?.removeHtmlTags() ?? "")
//                            .padding([.trailing, .leading, .bottom])
//                    }
                    
                        //TODO: list of series
//                    NavigationLink(destination: SeasonsListView(tvShowModel: tvShowModel)) {
//                        Text("Series they have participated in")
//                            .fontWeight(.semibold)
//                            .padding()
//                    }
                }
            }
//            .onAppear {
//                isFavorite = favoriteViewModel.isFavorite(tvShowModel)
//            }
            .navigationTitle(personModel.name)
//            .navigationBarItems(trailing:
//                Button {
//                    withAnimation(.default) {
//                        isFavorite = favoriteViewModel.isFavoriteToggle(tvShowModel)
//                    }
//                } label: {
//                    Image(isFavorite ? "star.fill" : "star")
//                        .foregroundColor(Color.accentColor)
//                        .imageScale(.large)
//                        .frame(width: 44, height: 44)
//                }
//            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    PersonDetailView()
}
