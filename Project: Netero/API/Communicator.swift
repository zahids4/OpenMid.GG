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
    let apiKey = "RGAPI-3cc61eb5-862b-44aa-9215-d570fe8aa4dd"
    let endIndexForGetMatchesCall = 10
    
    func getCallToSetLatestPatch(completionHandler: @escaping (String?, Error?) -> ()) {
        Alamofire.request("https://ddragon.leagueoflegends.com/api/versions.json").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler((value as! [String]).first, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getSummoner(region: String, summonerName: String, completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let encodedName = summonerName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        getCallForSummunor(region: region, encodedName: encodedName, completionHandler: completionHandler)
    }
    
    func getCallForSummunor(region: String, encodedName: String, completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/summoner/v3/summoners/by-name/\(encodedName)?api_key=" + apiKey).validate().responseJSON { response in
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
        Alamofire.request("https://\(region).api.riotgames.com/lol/match/v3/matchlists/by-account/\(accountId)?beginIndex=0&endIndex=\(endIndexForGetMatchesCall)&api_key=" + apiKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler((value as! [String:Any])["matches"] as? [[String:Any]], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getMatcheDetails(region: String, matchId: String, completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getCallForMatch(region, matchId, completionHandler)
    }
    
    func getCallForMatch(_ region: String,_ matchId: String,_ completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/match/v3/matches/\(matchId)?api_key=" + apiKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler((value as! [String:Any]), nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getSummunorRank(_ region: String,_ summonerId: String,_ completionHandler: @escaping ([[String:Any]]?, Error?) -> ()) {
        getCallForSummunorRank(region, summonerId, completionHandler)
    }
    
    func getCallForSummunorRank(_ region: String,_ summonerId: String,_ completionHandler: @escaping ([[String:Any]]?, Error?) -> ()) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/league/v3/positions/by-summoner/\(summonerId)?api_key=" + apiKey).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [[String:Any]], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getAllChampions(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        Alamofire.request("http://ddragon.leagueoflegends.com/cdn/\(AppDelegate.CURRENT_PATCH)/data/en_US/champion.json").validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler((value as! [String:Any])["data"] as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
