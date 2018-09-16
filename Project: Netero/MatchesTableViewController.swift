//
//  MatchesTableViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-07-07.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {
    let communicator = Communicator()
    
    var accountId: Int!
    var regionPlatform: String!
    var matchForCell = [String:Any]()
    var dataSource = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addBorder()
        getMatches()
    }
    
    fileprivate func getMatches() {
        communicator.getCallForSummunorMatches(regionPlatform, String(accountId)) { matches, error in
            if matches != nil {
                self.buildMatchesDatasource(matches)
            } else {
                print("An error occured: ", error as Any)
            }
            
        }
    }
    
    fileprivate func buildMatchesDatasource(_ matches: [[String : Any]]?) {
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "taskQueue")
        let dispatchSemaphore = DispatchSemaphore(value: 0)
        dispatchQueue.async {
            for match in matches! {
                dispatchGroup.enter()
                self.communicator.getMatcheDetails(region: self.regionPlatform, matchId: String(match.integerValueForKey("gameId"))) { matchDetails, error in
                    self.createDatasourceWith(match, matchDetails, error)
                    dispatchSemaphore.signal()
                    dispatchGroup.leave()
                }
                dispatchSemaphore.wait()
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func createDatasourceWith(_ match: [String:Any] ,_ matchDetails: [String:Any]?, _ error: Error?) {
        if matchDetails != nil {
            let participantsArray = matchDetails!.arrayForKey("participants") as! [[String: Any]]
            let championId = match.integerValueForKey("champion")
            let summoner = participantsArray.first(where: {$0["championId"] as! Int == championId})
            let teamId = summoner?.integerValueForKey("teamId")
            let teamsArray = matchDetails!.arrayForKey("teams") as! [[String: Any]]
            let summonerTeam = teamsArray.first(where: {($0["teamId"] as! Int) == teamId})
            let didWin = summonerTeam?.stringValueForKey("win") == "Win"
            let stats = summoner?.stringAnyObjectForKey("stats")
            let matchObject = self.buildMatchObject(didWin, championId, stats, matchDetails, summoner)
            self.dataSource.append(matchObject)
        } else {
            print("An error occured: ", error!)
        }
    }
    
    fileprivate func buildMatchObject(_ didWin: Bool, _ championId: Int, _ stats: [String : Any]?, _ matchDetails: [String:Any]?,_ summoner: [String:Any]?) -> [String:Any] {
        var matchObject = [String: Any]()
        matchObject["matchDetails"] = matchDetails
        matchObject["didWin"] = didWin
        matchObject["championId"] = championId
        matchObject["kills"] = stats!.integerValueForKey("kills")
        matchObject["assists"] = stats!.integerValueForKey("assists")
        matchObject["deaths"] = stats!.integerValueForKey("deaths")
        matchObject["cs"] = stats!.integerValueForKey("totalMinionsKilled")
        matchObject["spell1Id"] = summoner!.integerValueForKey("spell1Id")
        matchObject["spell2Id"] = summoner!.integerValueForKey("spell2Id")
        for i in 0...5 {
            matchObject["item\(i)"] = stats!.integerValueForKey("item\(i)")
        }
        return matchObject
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableViewCell
        let match = dataSource[indexPath.row]
        cell.configureUsing(match)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        matchForCell = dataSource[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetailedMatchView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailedMatchView" {
            let detailedMatchView = segue.destination as! DetailedMatchViewController
            detailedMatchView.match = matchForCell
        }
    }
}
