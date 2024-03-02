//
//  MockData.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation

struct MockData {
    
    //MARK: TVShows
    
    static let schedule = ScheduleModel(time: "20:00", days: ["Monday", "Tuesday"])
    static let rating = RatingModel(average: 8.2)
    static let country = CountryModel(name: "United States", code: "US", timezone: "America/New_York")
    static let network = NetworkModel(id: 1, name: "ABC", country: country, officialSite: "https://www.abc.com/")
    static let externals = ExternalsModel(tvrage: 12345, thetvdb: 54321, imdb: "tt1234567")
    static let image = ImageModel(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                                  original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg")
    static let selfLink = SelfLinkModel(href: "https://example.com/shows/123")
    static let previousEpisode = PreviousEpisodeModel(href: "https://example.com/episodes/456")
    static let links = LinksModel(selfLink: selfLink, previousepisode: previousEpisode)

    static let tvShow1 = TVShowModel(
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
    
    static let tvShow2 = TVShowModel(
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
    
    static let tvShow3 = TVShowModel(
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
    
    static let tvShows = [tvShow1, tvShow2, tvShow3]
    
    //MARK: Seasons
    
    static var season1 = SeasonModel(
        id: 1,
        url: "https://www.tvmaze.com/seasons/1/under-the-dome-season-1",
        number: 1,
        name: "",
        episodeOrder: 13,
        premiereDate: "2013-06-24",
        endDate: "2013-09-16",
        network: NetworkModel(
            id: 2,
            name: "CBS",
            country: CountryModel(
                name: "United States",
                code: "US",
                timezone: "America/New_York"
            ),
            officialSite: "https://www.cbs.com/"
        ),
        webChannel: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/24/60941.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/24/60941.jpg"
        ),
        summary: "",
        links: LinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/seasons/1"),
            previousepisode: PreviousEpisodeModel(href: "")
        )
    )

    static var season2 = SeasonModel(
        id: 2,
        url: "https://www.tvmaze.com/seasons/1/under-the-dome-season-1",
        number: 2,
        name: "",
        episodeOrder: 13,
        premiereDate: "2013-06-24",
        endDate: "2014-09-16",
        network: NetworkModel(
            id: 2,
            name: "CBS",
            country: CountryModel(
                name: "United States",
                code: "US",
                timezone: "America/New_York"
            ),
            officialSite: "https://www.cbs.com/"
        ),
        webChannel: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/24/60941.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/24/60941.jpg"
        ),
        summary: "",
        links: LinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/seasons/1"),
            previousepisode: PreviousEpisodeModel(href: "")
        )
    )
    
    static var season3 = SeasonModel(
        id: 3,
        url: "https://www.tvmaze.com/seasons/1/under-the-dome-season-1",
        number: 3,
        name: "",
        episodeOrder: 13,
        premiereDate: "2013-06-24",
        endDate: "2015-09-16",
        network: NetworkModel(
            id: 2,
            name: "CBS",
            country: CountryModel(
                name: "United States",
                code: "US",
                timezone: "America/New_York"
            ),
            officialSite: "https://www.cbs.com/"
        ),
        webChannel: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/24/60941.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/24/60941.jpg"
        ),
        summary: "",
        links: LinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/seasons/1"),
            previousepisode: PreviousEpisodeModel(href: "")
        )
    )
    
    static var seasons = [season1, season2, season3]

    //MARK: Episodes
    
    static let episode1 = EpisodeModel(
        id: 20982,
        url: "https://www.tvmaze.com/episodes/20982/hells-kitchen-7x01-16-chefs-compete",
        name: "16 Chefs Compete",
        season: 7,
        number: 1,
        type: "regular",
        airdate: "2010-06-01",
        airtime: "20:00",
        airstamp: "2010-06-02T00:00:00+00:00",
        runtime: 60,
        rating: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_landscape/303/759753.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/303/759753.jpg"
        ),
        summary: "<p>Chef Ramsay introduces himself to the 16 new contestants by announcing that they are expected to complete their very first dinner service. He then divides them into two teams, men vs. women, and sends them to the kitchen to prepare their signature dishes. After presenting the dishes to Chef Ramsay, he sends them up to study the menu and prepare for dinner service, which, unfortunately, does not go as he had hoped.</p>",
        links: EpisodeLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/episodes/20982"),
            show: ShowLinkModel(href: "https://api.tvmaze.com/shows/253")
        )
    )

    static let episode2 = EpisodeModel(
        id: 20983,
        url: "https://www.tvmaze.com/episodes/20983/hells-kitchen-7x02-15-chefs-compete",
        name: "15 Chefs Compete",
        season: 7,
        number: 2,
        type: "regular",
        airdate: "2010-06-08",
        airtime: "20:00",
        airstamp: "2010-06-09T00:00:00+00:00",
        runtime: 60,
        rating: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_landscape/303/759754.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/303/759754.jpg"
        ),
        summary: "<p>Summary for episode 2 goes here.</p>",
        links: EpisodeLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/episodes/20983"),
            show: ShowLinkModel(href: "https://api.tvmaze.com/shows/253")
        )
    )

    static let episode3 = EpisodeModel(
        id: 20984,
        url: "https://www.tvmaze.com/episodes/20984/hells-kitchen-7x03-14-chefs-compete",
        name: "14 Chefs Compete",
        season: 7,
        number: 3,
        type: "regular",
        airdate: "2010-06-15",
        airtime: "20:00",
        airstamp: "2010-06-16T00:00:00+00:00",
        runtime: 60,
        rating: nil,
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_landscape/303/759755.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/303/759755.jpg"
        ),
        summary: "<p>Summary for episode 3 goes here.</p>",
        links: EpisodeLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/episodes/20984"),
            show: ShowLinkModel(href: "https://api.tvmaze.com/shows/253")
        )
    )

    static let episodes = [episode1, episode2, episode3]
    
    //MARK: Person
    
    static let person1 = PersonModel(
        id: 5308,
        url: "https://www.tvmaze.com/people/5308/val-lauren",
        name: "Val Lauren",
        country: CountryModel(
            name: "United States",
            code: "US",
            timezone: "America/New_York"
        ),
        birthday: nil,
        deathday: nil,
        gender: "Male",
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/191/479296.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/191/479296.jpg"
        ),
        updated: 1685777646,
        links: PersonLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/people/5308")
        ),
        embedded: nil
    )

    static let person2 = PersonModel(
        id: 5309,
        url: "https://www.tvmaze.com/people/5309/jane-doe",
        name: "Jane Doe",
        country: CountryModel(
            name: "United States",
            code: "US",
            timezone: "America/New_York"
        ),
        birthday: "1990-01-01",
        deathday: nil,
        gender: "Female",
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/191/479297.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/191/479297.jpg"
        ),
        updated: 1685777646,
        links: PersonLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/people/5309")
        ),
        embedded: EmbeddedModel(
            castcredits: []
        )
    )

    static let person3 = PersonModel(
        id: 5310,
        url: "https://www.tvmaze.com/people/5310/john-smith",
        name: "John Smith",
        country: CountryModel(
            name: "United Kingdom",
            code: "UK",
            timezone: "Europe/London"
        ),
        birthday: "1985-05-15",
        deathday: "2020-12-31",
        gender: "Male",
        image: ImageModel(
            medium: "https://static.tvmaze.com/uploads/images/medium_portrait/191/479298.jpg",
            original: "https://static.tvmaze.com/uploads/images/original_untouched/191/479298.jpg"
        ),
        updated: 1685777646,
        links: PersonLinksModel(
            selfLink: SelfLinkModel(href: "https://api.tvmaze.com/people/5310")
        ),
        embedded: nil
    )
    
    static let personList = [person1, person2, person3]
}
