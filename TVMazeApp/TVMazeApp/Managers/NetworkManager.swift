//
//  NetworkManager.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation
import UIKit

enum Paths: String {
    case shows
    case search
    case seasons
    case episodes
}

enum Endpoint {
//    case tvShowById(_ idTVShow: Int)
    case tvShowBySearch
    case tvShowAll
    case seasons(_ idTVShow: Int)
    case episodes(_ idSeason: Int)
    
    var path: String {
        switch self {
//        case .tvShowById(let id):
//            return Paths.shows.rawValue + "/" + String(id)
            
        case .tvShowBySearch:
            return Paths.search.rawValue + "/" + Paths.shows.rawValue
            
        case .tvShowAll:
            return Paths.shows.rawValue
            
        case .seasons(let idTVShow):
            return Paths.shows.rawValue + "/" + String(idTVShow) + "/" + Paths.seasons.rawValue
            
        case .episodes(let idSeason):
            return Paths.seasons.rawValue + "/" + String(idSeason) + "/" + Paths.episodes.rawValue
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseUrl = "https://api.tvmaze.com/"
    
    private init() {

    }
    
//    func getTVShows(completed: @escaping (Result<[TVShowModel], CustomError>) -> Void) {
//
//        guard let url = URL(string: tvShowUrl) else {
//            completed(.failure(.invalidUrl))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
//
//            if error != nil {
//                completed(.failure(.unableToComplete))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let decodedResponse = try decoder.decode([TVShowModel].self, from: data)
//                completed(.success(decodedResponse))
//
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        })
//
//        task.resume()
//    }
    
//    func get(endpoint: Endpoint) async throws -> Codable {
//        return []
//    }
    
    static func buildUrl(path: String) -> String {
        return baseUrl + path
    }
    
    static func getAllShows(page: Int = 0) async throws -> [TVShowModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.tvShowAll.path))
        components?.queryItems = []
        
        if page > 0 {
            components?.queryItems?.append(contentsOf: [URLQueryItem(name: "page", value: String(page))])
        }
        
        guard let url = components?.url else {
            throw CustomError.invalidUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([TVShowModel].self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
    
    static func searchTVShow(searchQuery: String) async throws -> [TVShowModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.tvShowBySearch.path))
        components?.queryItems = []
                
        if !searchQuery.isEmpty {
            components?.queryItems?.append(contentsOf: [URLQueryItem(name: "q", value: searchQuery)])
        }
        
        guard let url = components?.url else {
            throw CustomError.invalidUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([SearchResponse].self, from: data)
            let result = decodedResponse.map({ $0.show })
            return result
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
    
    static func getSeasons(idTvShow: Int) async throws -> [SeasonModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.seasons(idTvShow).path))
        components?.queryItems = []
        
        guard let url = components?.url else {
            throw CustomError.invalidUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([SeasonModel].self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
    
    static func getEpisodes(idSeason: Int) async throws -> [EpisodeModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.episodes(idSeason).path))
        components?.queryItems = []
        
        guard let url = components?.url else {
            throw CustomError.invalidUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([EpisodeModel].self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
        
//    func downloadImage(fromURLString urlString: String, completion: @escaping (UIImage?) -> Void) {
//
//        let cacheKey = NSString(string: urlString)
//
//        if let image = cache.object(forKey: cacheKey) {
//            completion(image)
//            return
//        }
//
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//
//            guard let data, let image = UIImage(data: data) else {
//                completion(nil)
//                return
//            }
//
//            self.cache.setObject(image, forKey: cacheKey)
//
//            completion(image)
//        }
//
//        task.resume()
//    }
    
    func downloadImageAsync(fromURLString urlString: String) async throws -> UIImage {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            throw CustomError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let image = UIImage(data: data)
        else {
            throw CustomError.invalidResponse
        }
        
        self.cache.setObject(image, forKey: cacheKey)
        
        return image
    }
}
