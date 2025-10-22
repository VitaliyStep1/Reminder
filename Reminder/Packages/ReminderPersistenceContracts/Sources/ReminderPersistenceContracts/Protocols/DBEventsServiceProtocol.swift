//
//  DBEventsServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import Foundation

public protocol DBEventsServiceProtocol: Sendable {
  func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String, remindRepeat: Int) async throws
  func editEvent(eventId: ObjectId, title: String, date: Date, comment: String, remindRepeat: Int, newCategoryId: ObjectId?) async throws
  func deleteEvent(eventId: ObjectId) async throws
  func fetchEvents(categoryId: ObjectId) async throws -> [Event]
  func fetchEvent(eventId: ObjectId) async throws -> Event
}
