//
//  NetworkManager+Seasons.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import Foundation

extension NetworkManager {
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
}
