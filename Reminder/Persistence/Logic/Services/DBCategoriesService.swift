//
//  DBCategoriesService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import CoreData

class DBCategoriesService: DBCategoriesServiceProtocol {
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
          fetchRequest.predicate = NSPredicate(format: "defaultKey == %@", category.defaultKey)
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
    try await container.performBackgroundTask { context in
      let request = NSFetchRequest<CategoryObject>(entityName: "CategoryObject")
      request.sortDescriptors = [
        NSSortDescriptor(key: "order", ascending: true),
        NSSortDescriptor(key: "title", ascending: true)
      ]
      request.fetchBatchSize = 64
      request.returnsObjectsAsFaults = false
      
      let rows = try context.fetch(request)
      
      return try rows.map { categoryObject in
        let request: NSFetchRequest<EventObject> = EventObject.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", categoryObject)
        request.includesSubentities = false
        let eventCount = try context.count(for: request)
        
        return Category(
          id: categoryObject.objectID,
          defaultKey: categoryObject.defaultKey ?? "",
          title: categoryObject.title ?? "",
          order: Int(categoryObject.order),
          isUserCreated: categoryObject.isUserCreated,
          eventsAmount: eventCount
        )
      }
    }
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
  
  //For #Preview
  func takeFirstCategoryObjectId() async throws -> ObjectId? {
    try await container.performBackgroundTask { context in
      let request: NSFetchRequest<CategoryObject> = CategoryObject.fetchRequest()
      request.fetchLimit = 1
      request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
      return try context.fetch(request).first?.objectID
    }
  }
  
  func fetchCategory(categoryId: ObjectId) async throws -> Category? {
    try await container.performBackgroundTask { context in
    
      guard let categoryObject = try? context.existingObject(with: categoryId) as? CategoryObject else {
        return nil
      }
      
      let request: NSFetchRequest<EventObject> = EventObject.fetchRequest()
      request.predicate = NSPredicate(format: "category == %@", categoryObject)
      request.includesSubentities = false
      
      let count = try context.count(for: request)
      
      return Category(
        id: categoryObject.objectID,
        defaultKey: categoryObject.defaultKey ?? "",
        title: categoryObject.title ?? "",
        order: Int(categoryObject.order),
        isUserCreated: categoryObject.isUserCreated,
        eventsAmount: count
      )
    }
  }
}
