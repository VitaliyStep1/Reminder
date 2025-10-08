//
//  DataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//
import Foundation
import ReminderPersistence

typealias Category = ReminderPersistence.Category

protocol DataServiceProtocol {
  init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService:DBEventsServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol)
  func setupDataAtStart()
  
  func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws
  func editEvent(eventId: ObjectId, title: String, date: Date, comment: String) async throws
  func deleteEvent(eventId: ObjectId) async throws
  
  func fetchEvents(categoryId: ObjectId) async throws -> [Event]
  func fetchEvent(eventId: ObjectId) async throws -> Event
  
  func takeAllCategories() async -> [Category]?
  func fetchCategory(categoryId: ObjectId) async throws -> Category?
}
