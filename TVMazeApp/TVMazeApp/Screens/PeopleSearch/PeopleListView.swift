//
//  PeopleSearchView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct PeopleListView: View {
    @EnvironmentObject var viewModel: PersonViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    
                    //TODO: Implement pagination
                                                            
                    LazyVGrid(columns: viewModel.columns) {
                                                                        
                        ForEach(viewModel.personModel) { person in
                            PersonCellView(personModel: person)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Type your search here")
                    .onSubmit(of: .search) {
                        print(".onSubmit(of: .search)")
                        runSearch()
                    }
                    .navigationTitle("🕵🏻‍♀️ People search")
                    
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .onAppear() {
                runSearch()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .environmentObject(viewModel)
    }
    
    func runSearch() {
        Task {
            viewModel.getPerson(searchQuery: viewModel.searchText)
        }
    }
}

#Preview {
    PeopleListView()
}
