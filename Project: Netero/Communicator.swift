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
    
    func getSummoner(region: String, summonerName: String) {
        Alamofire.request("https://\(region).api.riotgames.com/lol/summoner/v3/summoners/by-name/\(summonerName)?api_key=" + apiKey).validate().responseJSON { response in
            print("Result: \(response.result)")  // response
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
