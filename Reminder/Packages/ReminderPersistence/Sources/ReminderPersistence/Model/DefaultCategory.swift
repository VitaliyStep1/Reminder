//
//  DefaultCategory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

public struct DefaultCategory {
  let defaultKey: String
  var title: String
  let order: Int
  let isUserCreated: Bool
  
  public init(defaultKey: String, title: String, order: Int, isUserCreated: Bool) {
    self.defaultKey = defaultKey
    self.title = title
    self.order = order
    self.isUserCreated = isUserCreated
  }
}
