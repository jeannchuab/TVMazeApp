//
//  SeasonModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 29/02/24.
//

import Foundation

struct SeasonModel: Codable, Identifiable {
    let id: Int
    let url: String
    let number: Int
    let name: String?
    let episodeOrder: Int?
    let premiereDate: String?
    let endDate: String?
    let network: NetworkModel?
    let webChannel: WebChannelModel?
    let image: ImageModel?
    let summary: String?
    let links: LinksModel?

    private enum CodingKeys: String, CodingKey {
        case id, url, number, name, episodeOrder, premiereDate, endDate, network, webChannel, image, summary
        case links = "_links"
    }
    
    var premieredFormatted: String {
        guard let premiered = self.premiereDate else { return "" }
        return premiered.formattedDate()
    }
        
    var title: String {
        var result = "Season \(number)"
        
        if !premieredFormatted.isEmpty {
            result = result.isEmpty ? premieredFormatted : "\(result) - \(premieredFormatted)"
        }
        
        return result
    }
}
