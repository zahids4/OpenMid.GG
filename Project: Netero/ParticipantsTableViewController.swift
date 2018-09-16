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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatasource()
    }
    
    fileprivate func createDatasource() {
        participants.forEach { p in
            let participantObject = buildParticipantObjectWith(p)
            self.dataSource.append(participantObject)
        }
        
    }
    
    fileprivate func buildParticipantObjectWith(_ participant: [String:Any]) -> [String:Any] {
        var participantObject = [String: Any]()
        let stats = participant.stringAnyObjectForKey("stats")
        participantObject["championId"] = participant.integerValueForKey("championId")
        participantObject["kills"] = stats.integerValueForKey("kills")
        participantObject["assists"] = stats.integerValueForKey("assists")
        participantObject["deaths"] = stats.integerValueForKey("deaths")
        participantObject["spell1Id"] = participant.integerValueForKey("spell1Id")
        participantObject["spell2Id"] = participant.integerValueForKey("spell2Id")
        for i in 0...5 {
            participantObject["item\(i)"] = stats.integerValueForKey("item\(i)")
        }
        
        return participantObject
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath) as! ParticipantTableViewCell
        let participant = dataSource[indexPath.row]
        cell.configureUsing(participant)
        return cell
    }
}
