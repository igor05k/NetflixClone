//
//  MoviesAndTVShowsResponse.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 25/09/22.
//

import Foundation

struct MoviesResponse: Codable {
    let results: [Movies]
}

struct Movies: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double
}
