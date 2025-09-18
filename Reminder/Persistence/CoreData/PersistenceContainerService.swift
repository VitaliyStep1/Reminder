//
//  PersistenceContainerService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 15.09.2025.
//

import CoreData

final class PersistenceContainerService {
  
  func createPersistentContainer(inMemory: Bool = false) -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "Model")
    if inMemory {
      let description = container.persistentStoreDescriptions.first
      description?.url = URL(fileURLWithPath: "/dev/null")
      description?.type = NSInMemoryStoreType
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
      }
    }
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }
}
