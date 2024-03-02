//
//  TVShowModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation

struct TVShowModel: Codable, Identifiable {
    let id: Int
    let url: String
    let name: String
    let type: String?
    let language: String?
    let genres: [String]
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: ScheduleModel?
    let rating: RatingModel?
    let weight: Int?
    let network: NetworkModel?
    let webChannel: WebChannelModel?
    let dvdCountry: CountryModel?
    let externals: ExternalsModel?
    let image: ImageModel?
    let summary: String?
    let updated: Int?
    let links: LinksModel?

    private enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
    
    var premieredFormatted: String {        
        var result = ""
        
        guard let premiered = self.premiered else { return "" }
        result = "Premiered at \(premiered.formattedDate())"
        
        guard let schedule = self.schedule else { return result }
        result = result + ", \(schedule.time)h"
        
        return result
    }
}

struct ScheduleModel: Codable {
    let time: String
    let days: [String]
}

struct RatingModel: Codable {
    let average: Double?
}

struct NetworkModel: Codable {
    let id: Int
    let name: String
    let country: CountryModel
    let officialSite: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, country, officialSite
    }
}

struct CountryModel: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct WebChannelModel: Codable {
    let id: Int
    let name: String
    let country: CountryModel?
    let officialSite: String?
}

struct ExternalsModel: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct ImageModel: Codable {
    let medium: String
    let original: String
}

struct LinksModel: Codable {
    let selfLink: SelfLinkModel?
    let previousepisode: PreviousEpisodeModel?

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case previousepisode
    }
}

struct SelfLinkModel: Codable {
    let href: String
}

struct PreviousEpisodeModel: Codable {
    let href: String
}

struct SearchResponse: Codable {
    let score: Double
    let show: TVShowModel
}
