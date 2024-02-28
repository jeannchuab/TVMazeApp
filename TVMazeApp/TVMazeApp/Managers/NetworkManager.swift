//
//  NetworkManager.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseUrl = "https://api.tvmaze.com/"
    private let tvShowUrl = baseUrl + "shows?page=1"
    
    private init() {

    }
    
    func getTVShows(completed: @escaping (Result<[TVShowModel], CustomError>) -> Void) {
        
        guard let url = URL(string: tvShowUrl) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            
            if error != nil {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([TVShowModel].self, from: data)
                completed(.success(decodedResponse))
                
            } catch {
                completed(.failure(.invalidData))
            }
        })
        
        task.resume()
    }
    
    func getTVShowsAsync(page: Int = 0) async throws -> [TVShowModel] {
                        
        var components = URLComponents(string: tvShowUrl)
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
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
    
    func downloadImage(fromURLString urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completion(image)
        }
        
        task.resume()
    }
    
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
