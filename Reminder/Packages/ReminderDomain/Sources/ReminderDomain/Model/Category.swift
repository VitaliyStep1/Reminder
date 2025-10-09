//
//  Category.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import ReminderPersistence

public struct Category: Identifiable {
  public let id: ObjectId
  public let defaultKey: String
  public var title: String
  public let order: Int
  public let isUserCreated: Bool
  public var eventsAmount: Int
  
  init(id: ObjectId, defaultKey: String, title: String, order: Int, isUserCreated: Bool, eventsAmount: Int) {
    self.id = id
    self.defaultKey = defaultKey
    self.title = title
    self.order = order
    self.isUserCreated = isUserCreated
    self.eventsAmount = eventsAmount
  }
  
  init(reminderPersistenceCategory: ReminderPersistence.Category) {
    self.id = reminderPersistenceCategory.id
    self.defaultKey = reminderPersistenceCategory.defaultKey
    self.title = reminderPersistenceCategory.title
    self.order = reminderPersistenceCategory.order
    self.isUserCreated = reminderPersistenceCategory.isUserCreated
    self.eventsAmount = reminderPersistenceCategory.eventsAmount
  }
}
