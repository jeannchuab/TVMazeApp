//
//  PersonDetailView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

struct PersonDetailView: View {
    var personId: Int
    @StateObject var viewModel = PersonDetailViewModel()
        
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    CustomRemoteImage(urlString: viewModel.personModel?.image?.original ?? "")
                        .scaledToFit()
                        .frame(height: 400)
                        .cornerRadius(12)
                                                            
                    Text(viewModel.personModel?.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .multilineTextAlignment(.center)
                        .padding([.trailing, .leading])
                        .scaledToFit()
                    
                    Text(viewModel.personModel?.birthdayFormated ?? "")
                        .font(.subheadline)
                        .padding([.trailing, .leading, .bottom])
                                        
                    Divider()
                        .foregroundColor(.accentColor)
                    
                    ZStack {
                        VStack {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Know for: ")
                                    .font(.headline)
                                    .padding([.trailing, .leading, .bottom])
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 16) {
                                    ForEach(viewModel.personTVShows ?? []) { tvShowModel in
                                        TVShowCellView(tvShowModel: tvShowModel)
                                    }
                                }
                            }
                            .padding([.trailing, .leading])
                        }
                        
                        if viewModel.isLoading {
                            LoadingView()
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getPersonById(id: personId)
            }
            .navigationTitle(viewModel.personModel?.name ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    PersonDetailView(personId: 0, viewModel: PersonDetailViewModel())
}
