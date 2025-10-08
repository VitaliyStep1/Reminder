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
  let isUserCreated = false
  
  public init(defaultKey: String, title: String, order: Int) {
    self.defaultKey = defaultKey
    self.title = title
    self.order = order
  }
}
