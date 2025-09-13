//
//  DBEventsService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import CoreData

class DBEventsService: DBEventsServiceProtocol {
  private let container: NSPersistentContainer
  private var context: NSManagedObjectContext {
    container.viewContext
  }
  
  init(container: NSPersistentContainer) {
    self.container = container
  }
  
  func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await container.performBackgroundTask { context in
      guard let category = try? context.existingObject(with: categoryId) as? CategoryObject else {
        throw FetchCategoryError.categoryWasNotFetched
      }
      
      let event = EventObject(context: context)
      event.title = title
      event.date = date
      event.comment = comment
      event.category = category
      try context.save()
    }
  }
  
  func fetchEvents(categoryId: ObjectId) async throws -> [Event] {
    try await container.performBackgroundTask { context in
      guard let category = try? context.existingObject(with: categoryId) as? CategoryObject else {
        throw FetchCategoryError.categoryWasNotFetched
      }
      
      let request = EventObject.fetchRequest()
      request.predicate = NSPredicate(format: "category == %@", category)
      request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
      request.returnsObjectsAsFaults = false
      let eventObjects = try context.fetch(request)
      let events = eventObjects.map { eventObject in
        Event(id: eventObject.objectID,
              title: eventObject.title ?? "",
              date: eventObject.date ?? Date(),
              comment: eventObject.comment ?? "", categoryId: category.objectID)
      }
      return events
    }
  }
}
