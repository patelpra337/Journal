//
//  CoreDataStack.swift
//  ios-journal-coredata
//
//  Created by patelpra on 2/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        
        let newContainer = NSPersistentContainer(name: "Journal")
        newContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return newContainer
    }()
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveToPersistentStore() {
        do {
            try mainContext.save()
        } catch {
           NSLog("Error saving context: \(error)")
            mainContext.reset()
        }
    }
}
