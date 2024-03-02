//
//  FavoriteViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import SwiftUI

struct FavoriteModel: Codable {
    let tvShow: TVShowModel
    let isFavorite: Bool
}

final class FavoriteViewModel: ObservableObject {    
    @AppStorage("favorites") private var favoritesData: Data?
    
    @Published private(set) var favoritesTvShows: [TVShowModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty && (oldValue != searchText) {
                getFavorites()
            }
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    init() {
        self.getFavorites()
    }
    
    func add(_ tvShow: TVShowModel) {
        self.favoritesTvShows.append(tvShow)
        do {
            favoritesData = try JSONEncoder().encode(favoritesTvShows)
        } catch {
            alertItem = AlertItem(error: .invalidFavorite)
        }
    }
        
    func remove(_ tvShow: TVShowModel) {
        self.favoritesTvShows.removeAll(where: { $0.id == tvShow.id })
        do {
            favoritesData = try JSONEncoder().encode(favoritesTvShows)
        } catch {
            alertItem = AlertItem(error: .invalidFavorite)
        }
    }
    
    func isFavorite(_ tvShow: TVShowModel) -> Bool {
        let result = self.favoritesTvShows.filter({ $0.id == tvShow.id })
        return !result.isEmpty
    }
    
    func isFavoriteToggle(_ tvShow: TVShowModel) -> Bool {
        if isFavorite(tvShow) {
            remove(tvShow)
            return false
        } else {
            add(tvShow)
            return true
        }
    }
    
    func getFavorites(searchQuery: String = "") {
        do {
            guard let favoritesData else { return }
            
            let result = try JSONDecoder().decode([TVShowModel].self, from: favoritesData)
            
            if searchQuery.isEmpty {
                favoritesTvShows = result.sorted(by: { $0.name < $1.name })
            } else {
                favoritesTvShows = result.filter({ $0.name.contains(searchQuery) }).sorted(by: { $0.name < $1.name })
            }                        
        } catch {
            alertItem = AlertItem(error: .invalidFavorite)
        }
    }
}
