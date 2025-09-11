//
//  PersistentService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 27.08.2025.
//

import CoreData

class PersistenceService {
  static let shared = PersistenceService()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Model") // matches .xcdatamodeld filename
    if inMemory {
      let description = container.persistentStoreDescriptions.first
      description?.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
      }
    }
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
