//
//  HeaderGroup.swift
//  AppStoreJson
//
//  Created by samer on 7/17/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation


struct HeaderDicGroup : Decodable{
    
    let dictionary = [HeaderGroup]()
}

struct HeaderGroup : Decodable{
    
    let id : String
    let name : String
    let imageUrl : String
    let tagline : String
    
    
}
