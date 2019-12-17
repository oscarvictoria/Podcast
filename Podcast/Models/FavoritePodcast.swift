//
//  FavoritePodcast.swift
//  Podcast
//
//  Created by Oscar Victoria Gonzalez  on 12/17/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct FavoritePodcast: Codable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}



//
//{
//    "trackId" : 1435076502,
//    "favoritedBy": "Alex Paul",
//    "collectionName" : "Swift over Coffee",
//    "artworkUrl600" : "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/3e/dc/7a/3edc7a05-9398-a4a9-ba2b-21587d6a0017/source/600x600bb.jpg"
//}
