//
//  SeasonsEpisodesViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

@MainActor
final class SeasonsViewModel: ObservableObject {
    @Published var seasonsModel: [SeasonModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false

    private func get(endpoint: Endpoint, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
                switch endpoint {
                    
                case .seasons(let idTvShow):
                    seasonsModel = []
                    seasonsModel = try await NetworkManager.getSeasons(idTvShow: idTvShow)
                    
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
    
    func getSeasons(idTVShow: Int) {
        get(endpoint: .seasons(idTVShow))
    }
}
