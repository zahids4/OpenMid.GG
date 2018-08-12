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
    var dataSource = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMatches()
    }
    
    fileprivate func getMatches() {
        communicator.getCallForSummunorMatches(regionPlatform, String(accountId)) { matches, error in
            if matches != nil {
                let dispatchGroup = DispatchGroup()
                for match in matches! {
                    dispatchGroup.enter()
                    
                    self.communicator.getMatcheDetails(region: self.regionPlatform, matchId: String(match.integerValueForKey("gameId"))) { matchDetails, error in
                        dispatchGroup.leave()
                        if matchDetails != nil {
                            let participantsArray = matchDetails!.arrayForKey("participants") as! [[String: Any]]
                            let summoner = participantsArray.first(where: {$0["championId"] as! Int == match.integerValueForKey("champion")})
                            let teamId = summoner?.integerValueForKey("teamId")
                            let teamsArray = matchDetails!.arrayForKey("teams") as! [[String: Any]]
                            let summonerTeam = teamsArray.first(where: {($0["teamId"] as! Int) == teamId})
                            let didWin = summonerTeam?.stringValueForKey("win") == "Win"
                            self.dataSource.append(didWin)
                        } else {
                            print("ERROR")
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    print("Finished getting all match.")
                    print(self.dataSource)
                }
            } else {
                print("An error occured", error as Any)
            }
            
        }
    }
    
    fileprivate func createMatchHistoryTableDatasource() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
