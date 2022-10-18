//
//  MoviesAndTVShowsResponse.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 25/09/22.
//

import Foundation

struct MoviesAndTVShowsResponse: Codable {
    let results: [MoviesAndTVShows]
}

struct MoviesAndTVShows: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Double
}
