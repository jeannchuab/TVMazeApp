//
//  TVShowViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

/*TODO
  Pagination
  Allow pin/password
  Allow FaceId
  Order Favorites alphabetically
  Create people search
  Show people details
  Unit tests
  Change from GRID to List
*/

@MainActor
final class TVShowViewModel: ObservableObject {
    @Published var tvShowsModel: [TVShowModel] = []
    @Published var seasonsModel: [SeasonModel] = []
    @Published var episodesModel: [EpisodeModel] = []
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
                switch endpoint {
                case .tvShowBySearch:
                    
                    tvShowsModel = []
                    tvShowsModel = try await NetworkManager.searchTVShow(searchQuery: searchQuery)
                    
                case .tvShowAll:
                    tvShowsModel = []
                    tvShowsModel = try await NetworkManager.getAllShows()
                    
                case .seasons(let idTvShow):
                    seasonsModel = []
                    seasonsModel = try await NetworkManager.getSeasons(idTvShow: idTvShow)
                    
                case .episodes(let idSeason):
                    episodesModel = []
                    episodesModel = try await NetworkManager.getEpisodes(idSeason: idSeason)
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
            get(endpoint: .tvShowAll)
        } else {
            get(endpoint: .tvShowBySearch, searchQuery: searchQuery)
        }
    }
    
    func getSeasons(idTVShow: Int) {
        get(endpoint: .seasons(idTVShow))
    }
    
    func getEpisodes(idSeason: Int) {
        get(endpoint: .episodes(idSeason))
    }
}
