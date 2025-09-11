//
//  DatabaseService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import CoreData

class DatabaseService: DatabaseServiceProtocol {
  private let container: NSPersistentContainer
  private var context: NSManagedObjectContext {
    container.viewContext
  }
  
  init(container: NSPersistentContainer) {
    self.container = container
  }
  
  func addOrUpdate(defaultCategories categories: [DefaultCategory]) async throws {
    guard !categories.isEmpty else {
      return
    }
    
    try await container.performBackgroundTask { context in
      let categoryDefaultKeys = categories.map(\.defaultKey)
      let addedDefaultKeys = try self.fetchAddedCategoryDefaultKeys(defaultKeys: categoryDefaultKeys, context: context)
      
      for category in categories {
        if addedDefaultKeys.contains(category.defaultKey) {
          let fetchRequest = CategoryObject.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "defaultKey == %d", category.defaultKey)
          fetchRequest.fetchLimit = 1
          if let categoryObject = try context.fetch(fetchRequest).first {
            categoryObject.title = category.title
            categoryObject.order = Int32(category.order)
          }
        } else {
          let categoryObject = CategoryObject(context: context)
          categoryObject.defaultKey = category.defaultKey
          categoryObject.title = category.title
          categoryObject.order = Int32(category.order)
          categoryObject.isUserCreated = category.isUserCreated
        }
      }
      
      if context.hasChanges {
        try context.save()
      }
    }
  }
  
  func fetchAllCategories() async throws -> [Category] {
    let request = NSFetchRequest<CategoryObject>(entityName: "CategoryObject")
    request.sortDescriptors = [
      NSSortDescriptor(key: "order", ascending: true),
      NSSortDescriptor(key: "title", ascending: true)
    ]
    let rows = try context.fetch(request)
    return rows.map{ $0.takeCategory() }
  }
  
  private func fetchAddedCategoryDefaultKeys(defaultKeys: [String], context: NSManagedObjectContext) throws -> Set<String> {
    guard !defaultKeys.isEmpty else {
      return []
    }
    let request = NSFetchRequest<NSDictionary>(entityName: "CategoryObject")
    request.resultType = .dictionaryResultType
    request.propertiesToFetch = ["defaultKey"]
    request.predicate = NSPredicate(format: "defaultKey IN %@", defaultKeys)
    let rows = try context.fetch(request)
    return Set(rows.compactMap { $0["defaultKey"] as? String })
  }
  
}
