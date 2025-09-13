//
//  DBEventsServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import Foundation

protocol DBEventsServiceProtocol {
  func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws
  func fetchEvents(categoryId: ObjectId) async throws -> [Event]
}
