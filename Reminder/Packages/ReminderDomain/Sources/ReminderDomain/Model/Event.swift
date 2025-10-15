//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation
import ReminderPersistenceContracts

public struct Event: Sendable {
  public let id: Identifier
  public let title: String
  public let date: Date
  public let comment: String
  public let categoryId: Identifier?
  
  init(id: Identifier, title: String, date: Date, comment: String, categoryId: Identifier?) {
    self.id = id
    self.title = title
    self.date = date
    self.comment = comment
    self.categoryId = categoryId
  }
  
  init(reminderPersistenceEvent: ReminderPersistenceContracts.Event) {
    self.id = reminderPersistenceEvent.id
    self.title = reminderPersistenceEvent.title
    self.date = reminderPersistenceEvent.date
    self.comment = reminderPersistenceEvent.comment
    self.categoryId = reminderPersistenceEvent.categoryId
  }
}
