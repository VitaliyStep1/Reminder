//
//  DefaultCategory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

import ReminderPersistenceContracts

public struct DefaultCategory {
  let defaultKey: String
  var title: String
  let order: Int
  let isUserCreated = false
  
  var reminderPersistenceDefaultCategory: ReminderPersistenceContracts.DefaultCategory {
    ReminderPersistenceContracts.DefaultCategory(defaultKey: defaultKey, title: title, order: order, isUserCreated: isUserCreated)
  }
}
