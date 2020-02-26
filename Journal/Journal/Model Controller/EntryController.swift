//
//  EntryController.swift
//  Journal
//
//  Created by patelpra on 2/19/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    //MARK: - Methods

    func createEntry(title: String, mood: JournalMood, bodyText: String, timestamp: Date? = Date(), identifier: String? = UUID().uuidString, context: NSManagedObjectContext ) {
        Entry(title: title,
              mood: mood,
              bodyText: bodyText,
              timestamp: timestamp,
              identifier: identifier,
              context: context)
        CoreDataStack.shared.saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, title: String, mood: JournalMood, bodyText: String?) {
        entry.title = title
        entry.bodyText = bodyText
        entry.timestamp = Date()
        entry.mood = mood.rawValue
        CoreDataStack.shared.saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        CoreDataStack.shared.mainContext.delete(entry)
        CoreDataStack.shared.saveToPersistentStore()
    }
}
