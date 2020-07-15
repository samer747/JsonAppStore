//
//  Services.swift
//  AppStoreJson
//
//  Created by samer on 7/15/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class Services {
    static let shared = Services()
        
        func fetchApps(complition: @escaping ([Result],Error?) -> ()){
            let stringURL = "https://itunes.apple.com/search?term=instagram&entity=software"
            guard let url = URL(string: stringURL) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, respone, err) in
                if let err = err {
                    //Faild:
                    print("Error in fethcing data: ",err)
                    complition([], err)
                    return
                }
                //Success:
                guard let data = data else { return }
                do{
                    let searchResults = try JSONDecoder().decode(SearchResult.self, from: data)
                    complition(searchResults.results, nil)
                }catch{
                    print("Faild to decode Json data: ",error)
                    complition([], error)
                }
                
            }.resume() // this fireing off the session
        }
}
