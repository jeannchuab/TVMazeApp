//
//  PersonSearchViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

@MainActor
final class PersonListViewModel: ObservableObject {
    @Published var personList: [PersonModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty && (oldValue != searchText) {
                getPersonBySearch(searchQuery: searchText)
            }
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var currentPage = 0
    
    func shouldLoadMoreData(person: PersonModel) {
        if person.id == personList.last?.id && searchText.isEmpty {            
            currentPage += 1
            getPersonBySearch(searchQuery: searchText)
        }
    }
        
    private func get(endpoint: Endpoint, page: Int, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {                
                switch endpoint {
                case .personAll:
                    personList = try await NetworkManager.getAllPerson(page: page)
                case .personBySearch:
                    personList = try await NetworkManager.searchPerson(searchQuery: searchQuery)
                default:
                    alertItem = AlertItem(error: .endpointNotFound)                    
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
    
    func getPersonBySearch(searchQuery: String) {
        if searchQuery.isEmpty {
            get(endpoint: .personAll, page: currentPage)
        } else {
            get(endpoint: .personBySearch, page: currentPage, searchQuery: searchQuery)
        }
    }
}
