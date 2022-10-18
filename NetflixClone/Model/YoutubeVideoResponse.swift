//
//  YoutubeVideoResponse.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 10/10/22.
//

import Foundation
//
struct YoutubeVideoResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElements
}

struct IdVideoElements: Codable {
    let kind: String
    let videoId: String
}

/*
 items =     (
             {
         etag = "_EPaRAoyQ7grohjz8IIhOio8_xg";
         id =             {
             kind = "youtube#video";
             videoId = gRkPk95SROE;
         };
         kind = "youtube#searchResult";
     },
 */
