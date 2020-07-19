//
//  AppsGroup.swift
//  AppStoreJson
//
//  Created by samer on 7/17/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

// de btet3ml 3la 7sb el json data w lazm tm4y 3al path bnf el asamy zy feed gwaha title w el results dictionary gwah name w hakza

struct AppsGroup : Decodable{
    let feed : Feed
}

struct Feed : Decodable {
    let title : String
    let results : [FeedResults]
}
struct FeedResults : Decodable {
    let artistName , name , artworkUrl100 , id : String
}
