//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation
import ReminderPersistence

public struct Event: Sendable {
  public let id: ObjectId
  public let title: String
  public let date: Date
  public let comment: String
  public let categoryId: ObjectId?
  
  init(id: ObjectId, title: String, date: Date, comment: String, categoryId: ObjectId?) {
    self.id = id
    self.title = title
    self.date = date
    self.comment = comment
    self.categoryId = categoryId
  }
  
  init(reminderPersistenceEvent: ReminderPersistence.Event) {
    self.id = reminderPersistenceEvent.id
    self.title = reminderPersistenceEvent.title
    self.date = reminderPersistenceEvent.date
    self.comment = reminderPersistenceEvent.comment
    self.categoryId = reminderPersistenceEvent.categoryId
  }
}
