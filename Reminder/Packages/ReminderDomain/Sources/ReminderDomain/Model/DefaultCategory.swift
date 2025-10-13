//
//  DefaultCategory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

import ReminderPersistence

public struct DefaultCategory {
  let defaultKey: String
  var title: String
  let order: Int
  let isUserCreated = false
  
  var reminderPersistenceDefaultCategory: ReminderPersistence.DefaultCategory {
    ReminderPersistence.DefaultCategory(defaultKey: defaultKey, title: title, order: order, isUserCreated: isUserCreated)
  }
}
