//
//  CoreDataHelper.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Max Tkach on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static let sharedInstance = CoreDataHelper()

    
    var entities: [String : [AnyObject]] = ["Pirate" : [Pirate](),
                                          "Ship" : [Ship](),
                                          "Engine" : [Engine]()]
    
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    func fetchData() {
        
        for (key, _) in entities {
            let fetchRequest = NSFetchRequest(entityName: key)
            
            do {
                entities[key] = try managedObjectContext.executeFetchRequest(fetchRequest)
            } catch let error as NSError {
                entities[key] = []
                print("Error while fetching \(key): \(error.localizedDescription)")
            }
        }
        
        if let pirates = self.entities["Pirate"] {
            let castedPirates = pirates as! [Pirate]
            if castedPirates.isEmpty {
                self.generateTestData()
                self.fetchData()
            }
        }
    }
    
    
    func generateTestData() {

        let pirateOne = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        let pirateTwo = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        let pirateThree = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        
        let shipOne = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        let shipTwo = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        let shipThree = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        let shipFour = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        let shipFive = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        let engineOne = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        let engineTwo = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        let engineThree = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        let engineFour = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        let engineFive = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        
        engineOne.propulsionType = "Anti-matter Drive"
        engineTwo.propulsionType = "Photon Drive"
        engineThree.propulsionType = "Hyper Drive"
        engineFour.propulsionType = "Ion Drive"
        engineFive.propulsionType = "Nuclear Drive"
        
        
        pirateOne.name = "Old Joe"
        pirateOne.ships = [shipFive]
        
        pirateTwo.name = "Baron"
        pirateTwo.ships = [shipOne, shipThree]
        
        pirateThree.name = "Tinker"
        pirateThree.ships = [shipTwo, shipFour]
        
        
        shipOne.name = "USS Invader"
        shipOne.engine = engineOne
        shipOne.pirate = pirateTwo
        
        shipTwo.name = "Hunter Seeker"
        shipTwo.engine = engineTwo
        shipTwo.pirate = pirateThree
        
        shipThree.name = "USS Doomsday"
        shipThree.engine = engineThree
        shipThree.pirate = pirateTwo
        
        shipFour.name = "Prototype v0.97"
        shipFour.pirate = pirateThree
        shipFour.engine = engineFour
        
        shipFive.name = "Old Wreck"
        shipFive.engine = engineFive
        shipFive.pirate = pirateOne
        
        self.saveContext()
    }

    
// MARK: - Core Data stack

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("swift-captain-morgans-relationships-lab.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
 
    
//MARK: Application's Documents directory

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    
}