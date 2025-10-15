//
//  DefaultCategory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

import ReminderPersistenceContracts

public struct DefaultCategory {
  public let defaultKey: String
  public var title: String
  public let order: Int
  public let isUserCreated = false
  
  public init(defaultKey: String, title: String, order: Int) {
    self.defaultKey = defaultKey
    self.title = title
    self.order = order
  }
}
