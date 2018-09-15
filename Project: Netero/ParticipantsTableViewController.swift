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
        setChampionIconFrom(id: participant.integerValueForKey("championId"), cell)
        setItemImagesOn(participant, cell)
        setSpellImagesFor(participant, cell)
        return cell
    }
    

    fileprivate func setItemImagesOn(_ participant: [String:Any],_ cell: ParticipantTableViewCell) {
        for (index, item) in cell.itemImages.enumerated() {
            let itemId = participant.integerValueForKey("item\(index)")
            if itemId != 0 {
                item.setItemImageWith(id: itemId)
            } else {
                item.image = UIImage(named: "black_line")
            }
        }
    }
    
    fileprivate func setChampionIconFrom(id: Int, _ cell: ParticipantTableViewCell) {
        communicator.getAllChampions() { allChampions, error in
            if allChampions != nil {
                for (key, value) in allChampions! {
                    if Int((value as! [String:Any]).stringValueForKey("key")) == id {
                        cell.championIconImage.setChampionIconWith(name: key)
                    }
                }
            } else {
                print("An error occured: ", error as Any)
            }
            
        }
    }
    
    fileprivate func setSpellImagesFor(_ participant: [String : Any], _ cell: ParticipantTableViewCell) {
        let spell1Name = "spell_\(participant.integerValueForKey("spell1Id"))"
        let spell2Name = "spell_\(participant.integerValueForKey("spell2Id"))"
        cell.spell1Image.image = UIImage(named: spell1Name)
        cell.spell2Image.image = UIImage(named: spell2Name)
    }
}
