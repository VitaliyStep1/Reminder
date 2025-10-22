//
//  DBEventsService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import CoreData
import ReminderPersistenceContracts

public final class DBEventsService: DBEventsServiceProtocol, @unchecked Sendable {
  private let container: NSPersistentContainer
  private var context: NSManagedObjectContext {
    container.viewContext
  }
  
  public init(container: NSPersistentContainer) {
    self.container = container
  }
  
  public func createEvent(
    categoryId: ObjectId,
    title: String,
    date: Date,
    comment: String,
    remindRepeat: Int
  ) async throws {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { [self] context in
        do {
          guard let category = try self.fetchCategoryObject(with: categoryId, context: context) else {
            throw CreateEventError.categoryWasNotFetched
          }
          
          let event = EventObject(context: context)
          event.identifier = UUID()
          event.title = title
          event.date = date
          event.comment = comment
          event.remindRepeat = takeInt16RepeatValue(remindRepeat)
          event.category = category
          try context.save()

          continuation.resume(returning: ())
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func editEvent(
    eventId: ObjectId,
    title: String,
    date: Date,
    comment: String,
    remindRepeat: Int,
    newCategoryId: ObjectId?
  ) async throws {
    try await withCheckedThrowingContinuation { continuation in
      container.performBackgroundTask { [self] context in
        do {
          var newCategory: CategoryObject?
          if let newCategoryId {
            guard let category = try self.fetchCategoryObject(with: newCategoryId, context: context) else {
              throw CreateEventError.categoryWasNotFetched
            }
            newCategory = category
          }
          
          guard let eventObject = try self.fetchEventObject(with: eventId, context: context) else {
            throw EditEventError.eventWasNotFetched
          }
          
          // Update properties
          eventObject.title = title
          eventObject.date = date
          eventObject.comment = comment
          eventObject.remindRepeat = takeInt16RepeatValue(remindRepeat)
          if let newCategory {
            eventObject.category = newCategory
          }
          
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
          guard let eventObject = try self.fetchEventObject(with: eventId, context: context) else {
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
        do {
          guard let category = try self.fetchCategoryObject(with: categoryId, context: context) else {
            continuation.resume(throwing: FetchCategoryError.categoryWasNotFetched)
            return
          }
          
          let request = EventObject.fetchRequest()
          request.predicate = NSPredicate(format: "category == %@", category)
          request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
          request.returnsObjectsAsFaults = false
          let eventObjects = try context.fetch(request)
          let events = eventObjects.map { eventObject in
            Event(
              id: eventObject.identifier,
              title: eventObject.title ?? "",
              date: eventObject.date ?? Date(),
              comment: eventObject.comment ?? "",
              categoryId: category.identifier,
              remindRepeat: Int(eventObject.remindRepeat)
            )
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
        do {
          guard let eventObject = try self.fetchEventObject(with: eventId, context: context) else {
            continuation.resume(throwing: FetchEventError.eventWasNotFetched)
            return
          }
          
          let event = Event(
            id: eventObject.identifier,
            title: eventObject.title ?? "",
            date: eventObject.date ?? Date(),
            comment: eventObject.comment ?? "",
            categoryId: eventObject.category?.identifier,
            remindRepeat: Int(eventObject.remindRepeat)
          )

          continuation.resume(returning: event)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  private func fetchCategoryObject(with id: UUID, context: NSManagedObjectContext) throws -> CategoryObject? {
    let request: NSFetchRequest<CategoryObject> = CategoryObject.fetchRequest()
    request.predicate = NSPredicate(format: "identifier == %@", id as CVarArg)
    request.fetchLimit = 1
    return try context.fetch(request).first
  }
  
  private func fetchEventObject(with id: UUID, context: NSManagedObjectContext) throws -> EventObject? {
    let request: NSFetchRequest<EventObject> = EventObject.fetchRequest()
    request.predicate = NSPredicate(format: "identifier == %@", id as CVarArg)
    request.fetchLimit = 1
    return try context.fetch(request).first
  }

  private func takeInt16RepeatValue(_ remindRepeat: Int) -> Int16 {
      return Int16(remindRepeat)
  }
}
