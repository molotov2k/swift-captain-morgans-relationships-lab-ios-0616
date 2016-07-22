//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Max Tkach on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    var ship = Ship?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ship = self.ship {
            self.shipNameLabel.text = ship.name
            
            if let pirate = ship.pirate {
                self.pirateNameLabel.text = pirate.name
            }
            
            if let engine = ship.engine {
                self.propulsionTypeLabel.text = engine.propulsionType
            }
        }
    }
}

