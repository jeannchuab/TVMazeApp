//
//  NetworkManager+Person.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import Foundation

extension NetworkManager {
    static func getAllPerson(page: Int = 0) async throws -> [PersonModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.personAll.path))
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
            let decodedResponse = try decoder.decode([PersonModel].self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
    
    static func searchPerson(searchQuery: String) async throws -> [PersonModel] {
        var components = URLComponents(string: buildUrl(path: Endpoint.personBySearch.path))
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
            let decodedResponse = try decoder.decode([PersonSearchResponse].self, from: data)
            let result = decodedResponse.map({ $0.person })
            return result
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
    
    static func getPerson(id: Int, embedCastCredits: Bool = true) async throws -> PersonModel {
        var components = URLComponents(string: buildUrl(path: Endpoint.personById(id).path))
        components?.queryItems = []
                
        if embedCastCredits {
            components?.queryItems?.append(contentsOf: [URLQueryItem(name: "embed", value: "castcredits")])
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
            let decodedResponse = try decoder.decode(PersonModel.self, from: data)
            return decodedResponse
        } catch let error {
            print(error)
            throw CustomError.invalidData
        }
    }
}
