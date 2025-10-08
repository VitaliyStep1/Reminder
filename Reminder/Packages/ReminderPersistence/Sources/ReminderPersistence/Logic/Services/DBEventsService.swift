//
//  DBEventsService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import CoreData

public class DBEventsService: DBEventsServiceProtocol {
  private let container: NSPersistentContainer
  private var context: NSManagedObjectContext {
    container.viewContext
  }
  
  public init(container: NSPersistentContainer) {
    self.container = container
  }
  
  public func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { context in
        do {
          guard let category = try context.existingObject(with: categoryId) as? CategoryObject else {
            throw CreateEventError.categoryWasNotFetched
          }
          
          let event = EventObject(context: context)
          event.title = title
          event.date = date
          event.comment = comment
          event.category = category
          try context.save()
          
          continuation.resume(returning: ())
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func editEvent(eventId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { context in
        do {
          guard let eventObject = try context.existingObject(with: eventId) as? EventObject else {
            throw EditEventError.eventWasNotFetched
          }
          
          // Update properties
          eventObject.title = title
          eventObject.date = date
          eventObject.comment = comment
          
          try context.save()
          
          continuation.resume(returning: ())
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func deleteEvent(eventId: ObjectId) async throws {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { context in
        do {
          guard let eventObject = try context.existingObject(with: eventId) as? EventObject else {
            throw DeleteEventError.eventWasNotFetched
          }
          
          context.delete(eventObject)
          try context.save()
          
          continuation.resume(returning: ())
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func fetchEvents(categoryId: ObjectId) async throws -> [Event] {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { context in
        guard let category = try? context.existingObject(with: categoryId) as? CategoryObject else {
          continuation.resume(throwing: FetchCategoryError.categoryWasNotFetched)
          return
        }
        do {
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
          continuation.resume(returning: events)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func fetchEvent(eventId: ObjectId) async throws -> Event {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { context in
        guard let eventObject = try? context.existingObject(with: eventId) as? EventObject else {
          continuation.resume(throwing: FetchEventError.eventWasNotFetched)
          return
        }
        
        let event = Event(
          id: eventObject.objectID,
          title: eventObject.title ?? "",
          date: eventObject.date ?? Date(),
          comment: eventObject.comment ?? "",
          categoryId: eventObject.category?.objectID
        )
        
        continuation.resume(returning: event)
      }
    }
  }
}
