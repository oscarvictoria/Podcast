//
//  ApplePodcast.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/16/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct ApplePodcast: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let trackId: Int
    let artistName: String?
    let collectionName: String
    let trackName: String?
    let artworkUrl600: String
    let trackCount: Int?
//    let genres: [String]
    let favoritedBy: String?

    
}
