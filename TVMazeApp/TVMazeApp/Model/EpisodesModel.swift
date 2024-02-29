//
//  EpisodesModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import Foundation

struct EpisodeModel: Codable, Identifiable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int?
    let type: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let rating: RatingModel?
    let image: ImageModel?
    let summary: String?
    let links: EpisodeLinksModel?
    
    private enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links = "_links"
    }
    
    var airDateTimeFormatted: String {
        var result = ""
        
        guard let premiered = self.airdate else { return "" }
        result = "\(premiered.formattedDate())"
        
        return result
    }
    
    var title: String {
        var result = ""
        
        if let number {
            result = "Episode \(number)"
        }
        
        if !airDateTimeFormatted.isEmpty {
            result = result.isEmpty ? airDateTimeFormatted : "\(result) - \(airDateTimeFormatted)"
        }
        
        return result
    }
    
    var seasonEpisodeTitleFormatted: String {
        var result = "Season \(season)"
        
        if let number {
            result = result + " - Episode \(number)"
        }
        
        return result
    }
        
}

struct EpisodeLinksModel: Codable {
    let selfLink: SelfLinkModel
    let show: ShowLinkModel

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case show
    }
}

struct ShowLinkModel: Codable {
    let href: String
}
