//
//  SearchResult.swift
//  AppStoreJson
//
//  Created by samer on 7/15/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

struct SearchResult : Decodable {
    let resultCount: Int
    let results: [Result]
}
struct Result : Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl60 : String
    
    
}
