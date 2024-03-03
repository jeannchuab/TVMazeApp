//
//  PeopleSearchView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct PersonListView: View {
    @EnvironmentObject var viewModel: PersonListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 16) {                                                                        
                        ForEach(viewModel.personList) { person in
                            PersonCellView(personModel: person)
                                .onAppear {
                                    viewModel.shouldLoadMoreData(person: person)
                                }
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Type your search here")
                    .onSubmit(of: .search) {
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
            viewModel.getPersonBySearch(searchQuery: viewModel.searchText)
        }
    }
}

#Preview {
    PersonListView()
}
