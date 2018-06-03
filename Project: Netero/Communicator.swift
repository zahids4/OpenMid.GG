//
//  Communicator.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-06-03.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import Foundation
import Alamofire

class Communicator {
    let apiKey = "RGAPI-17f75ea7-2e99-4993-87f2-e3f989aafdd3"
    
    func getSummoner(region: String, summonerName: String, completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getCallForSummunor(region: region, summonerName: summonerName, completionHandler: completionHandler)
    }
    
    func getCallForSummunor(region: String, summonerName: String, completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/summoner/v3/summoners/by-name/\(summonerName)?api_key=" + apiKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getMatchesForSummoner(region: String, accountId: String, completionHandler: @escaping ([[String:Any]]?, Error?) -> ()) {
        getCallForSummunorMatches(region, accountId, completionHandler)
    }
    
    func getCallForSummunorMatches(_ region: String,_ accountId: String,_ completionHandler: @escaping ([[String:Any]]?, Error?) -> ()) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/match/v3/matchlists/by-account/\(accountId)?api_key=" + apiKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [[String:Any]], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}
