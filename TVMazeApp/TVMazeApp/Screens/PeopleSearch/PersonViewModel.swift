//
//  PersonSearchViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

@MainActor
final class PersonViewModel: ObservableObject {
    @Published var personModel: [PersonModel] = []

    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty && (oldValue != searchText) {
                getPerson()
            }
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var currentPage = 0
    
//    func loadNextPage() {
//        currentPage += 1
//
//        isLoading = true
//
//        Task {
//            do {
//                let result = try await NetworkManager.getAllShows(page: currentPage)
//                tvShowsModel.append(contentsOf: result)
//            } catch let error {
//                if error is CustomError {
//                    guard let customError = error as? CustomError else { return }
//                    alertItem = AlertItem(error: customError)
//                } else {
//                    alertItem = AlertItem(error: .invalidData)
//                }
//            }
//
//            isLoading = false
//        }
//    }
        
    private func get(endpoint: Endpoint, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
                personModel = []
                if endpoint == .personBySearch {
                    personModel = try await NetworkManager.searchPerson(searchQuery: searchQuery)
                } else if endpoint == .personAll {
                    personModel = try await NetworkManager.getAllPerson()
                }
            } catch let error {
                if error is CustomError {
                    guard let customError = error as? CustomError else { return }
                    alertItem = AlertItem(error: customError)
                } else {
                    alertItem = AlertItem(error: .invalidData)
                }
            }
            isLoading = false
        }
    }
    
    func getPerson(searchQuery: String = "") {
        if searchQuery.isEmpty {
            get(endpoint: .personAll)
        } else {
            get(endpoint: .personBySearch, searchQuery: searchQuery)
        }
    }
}
