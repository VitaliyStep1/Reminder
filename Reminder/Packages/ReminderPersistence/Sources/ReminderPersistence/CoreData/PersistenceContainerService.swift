//
//  PersistenceContainerService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 15.09.2025.
//

import CoreData

public final class PersistenceContainerService {
  
  public init() { }
  
//  public func createPersistentContainer(inMemory: Bool = false) -> NSPersistentContainer {
//    let container = NSPersistentContainer(name: "Model")
//    if inMemory {
//      let description = container.persistentStoreDescriptions.first
//      description?.url = URL(fileURLWithPath: "/dev/null")
//      description?.type = NSInMemoryStoreType
//    }
//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
//      }
//    }
//    container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
//    container.viewContext.automaticallyMergesChangesFromParent = true
//    return container
//  }
  
  public func createPersistentContainer(inMemory: Bool = false) -> NSPersistentContainer {
    // 1) Load the compiled model from the SPM bundle
    guard let url = Bundle.module.url(forResource: "Model", withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Could not load Model.momd from Bundle.module")
    }
    
    // 2) Normalize entity → class bindings (fixes "ReminderPersistence_ReminderPersistence.*")
    func normalizeClassNames(in model: NSManagedObjectModel) {
      // Map by entity name to Swift runtime class you actually ship
      let classMap: [String: NSManagedObject.Type] = [
        "CategoryObject": CategoryObject.self,
        "EventObject": EventObject.self,
      ]
      for (name, cls) in classMap {
        if let e = model.entitiesByName[name] {
          e.managedObjectClassName = NSStringFromClass(cls) // e.g. "ReminderPersistence.CategoryObject"
        }
      }
    }
    normalizeClassNames(in: model)
    
    // 3) Build container with THIS model (don’t use Bundle.main / mergedModel)
    let container = NSPersistentContainer(name: "Model", managedObjectModel: model)
    
    // 4) Configure store (supports in-memory)
    if inMemory {
      let desc = NSPersistentStoreDescription()
      desc.type = NSInMemoryStoreType
      container.persistentStoreDescriptions = [desc]
    }
    
    container.loadPersistentStores { _, error in
      if let error = error { fatalError("loadPersistentStores: \(error)") }
    }
    
    // Recommended context tweaks
    container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    container.viewContext.automaticallyMergesChangesFromParent = true
    
    // Debug: verify final bindings
#if DEBUG
    print("===== Entities in model (after normalize) =====")
    for e in model.entities {
      print("- \(e.name ?? "<no name>")  class=\(e.managedObjectClassName as Any)")
    }
    print("Swift runtime names:",
          NSStringFromClass(CategoryObject.self),
          NSStringFromClass(EventObject.self))
#endif
    
    return container
  }
}
