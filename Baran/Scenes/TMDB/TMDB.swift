//
//  TMDB.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

struct TMDBMResponse: Codable {
    let page: Int
    var results: [TMDB]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TMDB: Codable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originCountry: [String]?
    let originalLanguage: String?
    let originalTitle, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, firstAirDate: String?
    let name: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w300"
    }
}

struct YouTubeData: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: YouTubePageInfo?
    let items: [YouTubeItem]
}

struct YouTubeItem: Codable, Hashable {
    let kind, etag: String
    let id: YouTubeVideoID?
}

struct YouTubeVideoID: Codable, Hashable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct YouTubePageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
