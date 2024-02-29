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
    
    func getTVShows(searchQuery: String = "") {
        isLoading = true
                        
        Task {
            do {
                if searchQuery.isEmpty {
                    tvShowsModel = try await NetworkManager.getAllShows()
                } else {
                    tvShowsModel = try await NetworkManager.searchTVShow(searchQuery: searchQuery)
                }                
            } catch CustomError.invalidUrl {
                alertItem = AlertContext.invalidUrl
            } catch CustomError.invalidResponse {
                alertItem = AlertContext.invalidResponse
            } catch CustomError.invalidData {
                alertItem = AlertContext.invalidData
            } catch CustomError.unableToComplete {
                alertItem = AlertContext.unableToComplete
            } catch {
                alertItem = AlertContext.unableToComplete
            }
            
            isLoading = false
        }
    }
}
