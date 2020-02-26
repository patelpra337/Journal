//
//  Entry+Convenience.swift
//  ios-journal-coredata
//
//  Created by patelpra on 2/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

enum JournalMood: String, CaseIterable {
    case sad = "🙁"
    case normal = "😐"
    case happy = "🙂"
}

extension Entry {
    @discardableResult convenience init(title: String, mood: JournalMood, bodyText: String, timestamp: Date? = Date(), identifier: String? = UUID().uuidString, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.mood = mood.rawValue
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
    }
}
