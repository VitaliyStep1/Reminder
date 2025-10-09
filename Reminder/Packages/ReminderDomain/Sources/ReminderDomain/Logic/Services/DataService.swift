//
//  DataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation
import ReminderPersistence

public class DataService: DataServiceProtocol {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  private var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol
  
  public required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
    self.defaultCategoriesDataService = defaultCategoriesDataService
  }
  
  public func setupDataAtStart() async {
    let defaultCategories = defaultCategoriesDataService.takeDefaultCategories()
    let reminderPersistenceDefaultCategories = defaultCategories.map {
      $0.reminderPersistenceDefaultCategory
    }
    try? await dBCategoriesService.addOrUpdate(defaultCategories: reminderPersistenceDefaultCategories)
  }
  
  public func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
  
  public func editEvent(eventId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
  }
  
  public func deleteEvent(eventId: ObjectId) async throws {
    try await dBEventsService.deleteEvent(eventId: eventId)
  }
  
  public func takeAllCategories() async -> [Category]? {
    let reminderPersistenceCategories = try? await dBCategoriesService.fetchAllCategories()
    guard let reminderPersistenceCategories else {
      return nil
    }
    let categories = reminderPersistenceCategories.map {
      Category.init(reminderPersistenceCategory: $0)
    }
    return categories
  }
  
  public func fetchEvents(categoryId: ObjectId) async throws -> [Event] {
    let reminderPersistenceEvents = try await dBEventsService.fetchEvents(categoryId: categoryId)
    let events = reminderPersistenceEvents.map {
      Event.init(reminderPersistenceEvent: $0)
    }
    return events
  }
  
  public func fetchEvent(eventId: ObjectId) async throws -> Event {
    let reminderPersistenceEvent = try await dBEventsService.fetchEvent(eventId: eventId)
    let event = Event.init(reminderPersistenceEvent: reminderPersistenceEvent)
    return event
  }
  
  public func fetchCategory(categoryId: ObjectId) async throws -> Category? {
    let reminderPersistenceCategory = try? await dBCategoriesService.fetchCategory(categoryId: categoryId)
    let category = reminderPersistenceCategory.flatMap {
      Category.init(reminderPersistenceCategory: $0)
    }
    return category
  }
}
