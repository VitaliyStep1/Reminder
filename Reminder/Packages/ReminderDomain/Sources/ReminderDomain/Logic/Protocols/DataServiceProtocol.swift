//
//  DataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//
import Foundation
import ReminderPersistence

public protocol DataServiceProtocol: Sendable {
  init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService:DBEventsServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol)
  func setupDataAtStart() async
  
  func createEvent(categoryId: Identifier, title: String, date: Date, comment: String) async throws
  func editEvent(eventId: Identifier, title: String, date: Date, comment: String) async throws
  func deleteEvent(eventId: Identifier) async throws
  
  func fetchEvents(categoryId: Identifier) async throws -> [Event]
  func fetchEvent(eventId: Identifier) async throws -> Event
  
  func takeAllCategories() async throws -> [Category]
  func fetchCategory(categoryId: Identifier) async throws -> Category?
}
