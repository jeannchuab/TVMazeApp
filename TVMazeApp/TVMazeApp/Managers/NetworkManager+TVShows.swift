//
//  NetworkManager+TVShows.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import Foundation

extension NetworkManager {
    
    static func getTVShow(id: String) async throws -> TVShowModel {
        let components = URLComponents(string: buildUrl(path: Endpoint.tvShowById(id).path))
        
        guard let url = components?.url else {
            throw CustomError.invalidUrl
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(TVShowModel.self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
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
}
