//
//  Services.swift
//  AppStoreJson
//
//  Created by samer on 7/15/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class Services {
    //da ely hnady beh el  methods el public kolha
    static let shared = Services()
    //MARK: ------------ Search tab service -------------------
    func fetchSearchApps(searchTerm: String ,complition: @escaping (SearchResult?,Error?) -> ()){
            let stringURL = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
            fetchGenericJSONData(Url: stringURL, completion: complition)
        }
    //MARK: ------------ Apps tab service -------------------
    //MARK: -Apps Body
    func fetchTopGrossing(completion : @escaping (AppsGroup?,Error?) -> Void){
        fetchGenericJSONData(Url: "https://rss.itunes.apple.com/api/v1/eg/ios-apps/top-grossing/all/25/explicit.json", completion: completion)
    }
    func fetchTopFree(completion : @escaping (AppsGroup?,Error?) -> Void){
        fetchGenericJSONData(Url: "https://rss.itunes.apple.com/api/v1/eg/ios-apps/top-free/all/25/explicit.json", completion: completion)
    }
    func fetchTopPaid(completion : @escaping (AppsGroup?,Error?) -> Void){
        fetchGenericJSONData(Url: "https://rss.itunes.apple.com/api/v1/eg/ios-apps/top-paid/all/25/explicit.json", completion: completion)
    }
    //MARK: -Apps Header
    func fetchAppsHeaderData(completion : @escaping ([HeaderGroup]?,Error?) -> Void) {
        let stringUrl = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(Url: stringUrl, completion: completion)
    }
    
    //MARK: - Func gamda fsh55555555 -
    func fetchGenericJSONData<T: Decodable>(Url: String ,completion : @escaping (T?,Error?) -> ()) {
        guard let stringUrl = URL(string: Url) else { return }
        URLSession.shared.dataTask(with: stringUrl) { (data, res, err) in
            if let err = err {
                ///Faild
                completion(nil,err)
                return
            }
            ///Success
            do{
               let object =  try JSONDecoder().decode(T.self, from: data!)
                completion(object,nil)
            }catch{
                completion(nil,err)
                return
            }
        }.resume()
    }
}
