//
//  PeopleModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

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
    let updated: Int
    let links: PersonLinksModel

    private enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image, updated
        case links = "_links"
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
