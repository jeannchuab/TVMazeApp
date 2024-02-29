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

struct SampleTVShowModel {
    static let schedule = ScheduleModel(time: "20:00", days: ["Monday", "Tuesday"])
    static let rating = RatingModel(average: 8.2)
    static let country = CountryModel(name: "United States", code: "US", timezone: "America/New_York")
    static let network = NetworkModel(id: 1, name: "ABC", country: country, officialSite: "https://www.abc.com/")
    static let externals = ExternalsModel(tvrage: 12345, thetvdb: 54321, imdb: "tt1234567")
    static let image = ImageModel(medium: "https://example.com/medium.jpg", original: "https://example.com/original.jpg")
    static let selfLink = SelfLinkModel(href: "https://example.com/shows/123")
    static let previousEpisode = PreviousEpisodeModel(href: "https://example.com/episodes/456")
    static let links = LinksModel(selfLink: selfLink, previousepisode: previousEpisode)

    static let TVShow1 = TVShowModel(
        id: 1,
        url: "https://www.example.com/shows/123",
        name: "UP Adventures",
        type: "Scripted",
        language: "English",
        genres: ["Comedy", "Drama"],
        status: "Ongoing",
        runtime: 30,
        averageRuntime: 30,
        premiered: "2022-01-01",
        ended: "",
        officialSite: "https://www.example.com/",
        schedule: schedule,
        rating: rating,
        weight: 80,
        network: network,
        webChannel: nil,
        dvdCountry: nil,
        externals: externals,
        image: image,
        summary: "The Rookie is inspired by a true story. John Nolan is the oldest rookie in the LAPD. At an age where most are at the peak of their career, Nolan cast aside his comfortable, small town life and moved to L.A. to pursue his dream of being a cop. Now, surrounded by rookies twenty years his junior, Nolan must navigate the dangerous, humorous and unpredictable world of a 'young' cop, determined to make his second shot at life count.",
        updated: 1234567890,
        links: links
    )
    
    static let TVShow2 = TVShowModel(
        id: 2,
        url: "https://www.example.com/shows/123",
        name: "Star Wars: The Empire strikes back",
        type: "Scripted",
        language: "English",
        genres: ["Comedy", "Drama"],
        status: "Ongoing",
        runtime: 30,
        averageRuntime: 30,
        premiered: "2022-01-01",
        ended: "",
        officialSite: "https://www.example.com/",
        schedule: schedule,
        rating: rating,
        weight: 80,
        network: network,
        webChannel: nil,
        dvdCountry: nil,
        externals: externals,
        image: image,
        summary: "<p>This is a mock TV show summary.</p>",
        updated: 1234567890,
        links: links
    )
    
    static let TVShow3 = TVShowModel(
        id: 3,
        url: "https://www.example.com/shows/123",
        name: "Indiana Jones: Episode 1",
        type: "Scripted",
        language: "English",
        genres: ["Comedy", "Drama"],
        status: "Ongoing",
        runtime: 30,
        averageRuntime: 30,
        premiered: "2022-01-01",
        ended: "",
        officialSite: "https://www.example.com/",
        schedule: schedule,
        rating: rating,
        weight: 80,
        network: network,
        webChannel: nil,
        dvdCountry: nil,
        externals: externals,
        image: image,
        summary: "<p>This is a mock TV show summary.</p>",
        updated: 1234567890,
        links: links
    )
    
    static let list = [TVShow1, TVShow2, TVShow3]
}
