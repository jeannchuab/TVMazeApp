//
//  PeopleModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import Foundation

import Foundation

struct PersonModel: Codable, Identifiable {
    let id: Int
    let url: String
    let name: String
    let country: CountryModel?
    let birthday: String?
    let deathday: String?
    let gender: String?
    let image: ImageModel?
    let updated: Int?
    let links: PersonLinksModel?
    let embedded: EmbeddedModel?

    private enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image, updated
        case links = "_links"
        case embedded = "_embedded"
    }
    
    var birthdayFormated: String {
        var result = ""
        if let birthday {
            result = "\("Born on ") \(birthday.formattedDate())"
        }
        
        guard let country else { return result }
        result = result.isEmpty ? country.name : "\(result), \(country.name)"
        
        return result
    }
}

struct EmbeddedModel: Codable {
    let castcredits: [CastCreditModel]

    private enum CodingKeys: String, CodingKey {
        case castcredits
    }
}

struct CastCreditModel: Codable {
    let selfLink: Bool
    let voice: Bool
    let links: CastCreditLinksModel

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case voice
        case links = "_links"
    }
}

struct CastCreditLinksModel: Codable {
    let show: ShowLinkModel
    let character: CharacterLinkModel

    private enum CodingKeys: String, CodingKey {
        case show, character
    }
}

struct CharacterLinkModel: Codable {
    let href: String

    private enum CodingKeys: String, CodingKey {
        case href
    }
}

struct PersonLinksModel: Codable {
    let selfLink: SelfLinkModel

    private enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}

struct PersonSearchResponse: Codable {
    let score: Double
    let person: PersonModel

    private enum CodingKeys: String, CodingKey {
        case score, person
    }
}
