//
//  TVShowViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

@MainActor
final class TVShowViewModel: ObservableObject {
    @Published var tvShowsModel: [TVShowModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty && (oldValue != searchText) {
                getTVShows()
            }
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var currentPage = 0
        
    func shouldLoadMoreData(tvShow: TVShowModel) {        
        if tvShow.id == tvShowsModel.last?.id && searchText.isEmpty {
            print("Last cell")
            currentPage += 1
            getTVShows(searchQuery: searchText)
        }
    }
        
    private func get(endpoint: Endpoint, page: Int, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
                switch endpoint {
                case .tvShowBySearch:                    
                    tvShowsModel = []
                    tvShowsModel = try await NetworkManager.searchTVShow(searchQuery: searchQuery)
                    
                case .tvShowAll:
                    let result = try await NetworkManager.getAllShows(page: page)
                    if page == 0 {
                        tvShowsModel = []
                        tvShowsModel = result
                    } else {
                        tvShowsModel.append(contentsOf: result)
                    }
                    
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
    
    func getTVShows(searchQuery: String = "") {
        if searchQuery.isEmpty {
            get(endpoint: .tvShowAll, page: currentPage)
        } else {
            get(endpoint: .tvShowBySearch, page: currentPage, searchQuery: searchQuery)
        }
    }        
}
