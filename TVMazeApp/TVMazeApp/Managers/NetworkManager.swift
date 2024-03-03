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
    case people
    case person
}

enum Endpoint: Equatable {
    case tvShowById(_ idTVShow: String)
    case tvShowBySearch
    case tvShowAll
    case seasons(_ idTVShow: Int)
    case episodes(_ idSeason: Int)
    case personById(_ idPerson: Int)
    case personAll
    case personBySearch
    
    var path: String {
        switch self {
        case .tvShowById(let id):
            return Paths.shows.rawValue + "/" + String(id)
            
        case .tvShowBySearch:
            return Paths.search.rawValue + "/" + Paths.shows.rawValue
            
        case .tvShowAll:
            return Paths.shows.rawValue
            
        case .seasons(let idTVShow):
            return Paths.shows.rawValue + "/" + String(idTVShow) + "/" + Paths.seasons.rawValue
            
        case .episodes(let idSeason):
            return Paths.seasons.rawValue + "/" + String(idSeason) + "/" + Paths.episodes.rawValue
        
        case .personById(let idPerson):
            return Paths.people.rawValue + "/" + String(idPerson)
            
        case .personBySearch:
            return Paths.search.rawValue + "/" + Paths.people.rawValue
        
        case .personAll:
            return Paths.people.rawValue        
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseUrl = "https://api.tvmaze.com/"
    
    private init() {

    }
        
    static func buildUrl(path: String) -> String {
        return baseUrl + path
    }                    
    
    //MARK: Image    
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
