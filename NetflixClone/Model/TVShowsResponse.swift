//
//  MoviesAndTVShowsResponse.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 25/09/22.
//

import Foundation

struct TVShowsResponse: Codable {
    let results: [TVShows]
}

struct TVShows: Codable {
    let id: Int
    let media_type: String?
    // original_name NOT original_title
    let original_name: String?
    let poster_path: String?
    let overview: String?
    // first_air_date NOT release_date
    let first_air_date: String?
    let vote_average: Double
}
