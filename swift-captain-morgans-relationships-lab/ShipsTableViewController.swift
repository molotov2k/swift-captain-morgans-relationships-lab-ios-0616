//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Max Tkach on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipsTableViewController: UITableViewController {
    
    let appData = CoreDataHelper.sharedInstance
    var pirate = Pirate?()
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pirate = pirate, let ships = pirate.ships {
            return ships.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shipCell", forIndexPath: indexPath)
        
        if let pirate = pirate, let ships = pirate.ships, let textLabel = cell.textLabel {
            let shipsArray = Array(ships)
            textLabel.text = shipsArray[indexPath.row].name
        }
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! ShipDetailViewController
        
        if let selectedShipIndexPath = self.tableView.indexPathForSelectedRow, let pirate = self.pirate, let ships = pirate.ships {
            let shipsArray = Array(ships)
            destinationVC.ship = shipsArray[selectedShipIndexPath.row]
        }
    }
    
    
}