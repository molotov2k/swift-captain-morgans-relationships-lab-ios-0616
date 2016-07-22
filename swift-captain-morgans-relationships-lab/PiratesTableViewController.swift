//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Max Tkach on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PiratesTableViewController: UITableViewController {
    
    let appData = CoreDataHelper.sharedInstance
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appData.fetchData()
        self.tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pirates = appData.entities["Pirate"] {
            return pirates.count
        }
        
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pirateCell", forIndexPath: indexPath)
        
        if let pirates = appData.entities["Pirate"], let textLabel = cell.textLabel {
            textLabel.text = pirates[indexPath.row].name
        }
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! ShipsTableViewController
        
        if let selectedPirateIndexPath = self.tableView.indexPathForSelectedRow, let pirates = appData.entities["Pirate"] {
            destinationVC.pirate = pirates[selectedPirateIndexPath.row] as? Pirate
        }
    }
    
    
}