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
    
//    func removeSelectedPerson() {
//        selectedPersonModel = nil
//    }
    
    private func get(endpoint: Endpoint, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
//                personModel = []
                
                switch endpoint {
//                case .personById(let id):
//                    selectedPersonModel = nil
//                    selectedPersonModel = try await NetworkManager.getPerson(id: id)
//                    getTVShowsFrom(idPerson: id)
                case .personAll:
                    personList = try await NetworkManager.getAllPerson()
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
            get(endpoint: .personAll)
        } else {
            get(endpoint: .personBySearch, searchQuery: searchQuery)
        }
    }
}
