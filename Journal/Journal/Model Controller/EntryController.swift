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
    
// MARK: - Properties
    var entries: [Entry] {
        get {

            loadFromPersistentStore()
        }
        set {
            saveToPersistentStore()
        }
    }
    
    //MARK: - Methods
    func saveToPersistentStore() {
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    func loadFromPersistentStore() -> [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }
    
    func createEntry(title: String, bodyText: String, timestamp: Date? = Date(), identifier: String? = UUID().uuidString ) {
        Entry(title: title,
              bodyText: bodyText,
              timestamp: timestamp,
              identifier: identifier)
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String?) {
        entry.title = title
        entry.bodyText = bodyText
        entry.timestamp = Date()
        saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(entry)
        do {
            try moc.save()
        } catch {
            moc.reset()
            print("Error saving managed object context \(error)")
        }
    }
}
