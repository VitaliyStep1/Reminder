//
//  DataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation
import ReminderPersistenceContracts
import ReminderDomainContracts

public actor DataService: DataServiceProtocol {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  private var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol
  
  public init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
    self.defaultCategoriesDataService = defaultCategoriesDataService
  }
  
  public func setupDataAtStart() async {
    let defaultCategories = defaultCategoriesDataService.takeDefaultCategories()
    let reminderPersistenceDefaultCategories = defaultCategories.map {
      ReminderPersistenceContracts.DefaultCategory(defaultKey: $0.defaultKey, title: $0.title, order: $0.order, isUserCreated: $0.isUserCreated)
    }
    try? await dBCategoriesService.addOrUpdate(defaultCategories: reminderPersistenceDefaultCategories)
  }
  
  public func createEvent(categoryId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
  
  public func editEvent(eventId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
  }
  
  public func deleteEvent(eventId: Identifier) async throws {
    try await dBEventsService.deleteEvent(eventId: eventId)
  }
  
  public func takeAllCategories() async throws -> [ReminderDomainContracts.Category] {
    let reminderPersistenceCategories = try await dBCategoriesService.fetchAllCategories()
    let categories = reminderPersistenceCategories.map {
      ReminderDomainContracts.Category.init(id: $0.id, defaultKey: $0.defaultKey, title: $0.title, order: $0.order, isUserCreated: $0.isUserCreated, eventsAmount: $0.eventsAmount)
    }
    return categories
  }
  
  public func fetchEvents(categoryId: Identifier) async throws -> [ReminderDomainContracts.Event] {
    let reminderPersistenceEvents = try await dBEventsService.fetchEvents(categoryId: categoryId)
    let events = reminderPersistenceEvents.map {
      ReminderDomainContracts.Event.init(id: $0.id, title: $0.title, date: $0.date, comment: $0.comment, categoryId: $0.categoryId)
    }
    return events
  }
  
  public func fetchEvent(eventId: Identifier) async throws -> ReminderDomainContracts.Event {
    let reminderPersistenceEvent = try await dBEventsService.fetchEvent(eventId: eventId)
    let event = ReminderDomainContracts.Event.init(id: reminderPersistenceEvent.id, title: reminderPersistenceEvent.title, date: reminderPersistenceEvent.date, comment: reminderPersistenceEvent.comment, categoryId: reminderPersistenceEvent.categoryId)
    return event
  }
  
  public func fetchCategory(categoryId: Identifier) async throws -> ReminderDomainContracts.Category? {
    let reminderPersistenceCategory = try? await dBCategoriesService.fetchCategory(categoryId: categoryId)
    let category = reminderPersistenceCategory.flatMap {
      ReminderDomainContracts.Category.init(id: $0.id, defaultKey: $0.defaultKey, title: $0.title, order: $0.order, isUserCreated: $0.isUserCreated, eventsAmount: $0.eventsAmount)
    }
    return category
  }
}
