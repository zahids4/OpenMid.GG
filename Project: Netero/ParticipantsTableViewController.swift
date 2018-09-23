//
//  ParticipantsTableViewController.swift
//  Project: Netero
//
//  Created by Saim Zahid on 2018-09-15.
//  Copyright © 2018 Saim Zahid. All rights reserved.
//

import UIKit

class ParticipantsTableViewController: UITableViewController {
    let communicator = Communicator()
    
    var participants: [[String:Any]]!
    var participantIdentities: [[String:Any]]!
    var dataSource = [[String:Any]]()
    var summonerNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addBorder()
        createSummonerNamesArray()
        createDatasource()
    }
    
    fileprivate func createDatasource() {
        participants.forEach { p in
            let participantObject = buildParticipantObjectWith(p)
            self.dataSource.append(participantObject)
        }
    }
    
    fileprivate func createSummonerNamesArray() {
        participantIdentities.forEach { p in
            let player = p.stringAnyObjectForKey("player")
            let name = player.stringValueForKey("summonerName")
            self.summonerNames.append(name)
        }
    }
    
    
    fileprivate func buildParticipantObjectWith(_ participant: [String:Any]) -> [String:Any] {
        var participantObject = [String: Any]()
        let stats = participant.stringAnyObjectForKey("stats")
        participantObject["teamId"] = participant.integerValueForKey("teamId")
        participantObject["championId"] = participant.integerValueForKey("championId")
        participantObject["kills"] = stats.integerValueForKey("kills")
        participantObject["assists"] = stats.integerValueForKey("assists")
        participantObject["deaths"] = stats.integerValueForKey("deaths")
        setDidWin(stats, &participantObject)
        participantObject["cs"] = stats.integerValueForKey("totalMinionsKilled")
        participantObject["spell1Id"] = participant.integerValueForKey("spell1Id")
        participantObject["spell2Id"] = participant.integerValueForKey("spell2Id")
        participantObject["isMatchCell"] = false
        for i in 0...5 {
            participantObject["item\(i)"] = stats.integerValueForKey("item\(i)")
        }
        
        return participantObject
    }
    
    fileprivate func setDidWin(_ stats: [String : Any], _ participantObject: inout [String : Any]) {
        if stats.integerValueForKey("win") == 1 {
            participantObject["didWin"] = true
        } else {
            participantObject["didWin"] = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableViewCell
        let participant = dataSource[indexPath.row]
        let name = summonerNames[indexPath.row]
        cell.configureUsing(participant)
        cell.setSummonerName(name)
        return cell
    }
}
