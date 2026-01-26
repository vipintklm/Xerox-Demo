//
//  CoreDataStack.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "XeroxDemo")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

