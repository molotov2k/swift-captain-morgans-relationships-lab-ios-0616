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
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.pirates.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pirateCell", forIndexPath: indexPath)
        
        if let textLabel = cell.textLabel {
            textLabel.text = appData.pirates[indexPath.row].name
        }
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! ShipsTableViewController
        
        if let selectedPirateIndexPath = self.tableView.indexPathForSelectedRow {
            destinationVC.pirate = appData.pirates[selectedPirateIndexPath.row]
        }
    }
    
    
}