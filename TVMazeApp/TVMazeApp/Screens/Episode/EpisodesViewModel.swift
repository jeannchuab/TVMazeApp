//
//  EpisodesViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

final class EpisodesViewModel: ObservableObject {
    @Published var episodesModel: [EpisodeModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false

    private func get(endpoint: Endpoint, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
                switch endpoint {
                case .episodes(let idSeason):
                    episodesModel = []
                    episodesModel = try await NetworkManager.getEpisodes(idSeason: idSeason)
                    
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
    
    func getEpisodes(idSeason: Int) {
        get(endpoint: .episodes(idSeason))
    }
}
