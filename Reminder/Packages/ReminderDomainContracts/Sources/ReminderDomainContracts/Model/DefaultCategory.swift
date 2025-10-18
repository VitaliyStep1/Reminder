//
//  DefaultCategory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

public struct DefaultCategory {
  public let defaultKey: String
  public var title: String
  public let order: Int
  public let isUserCreated = false
  public let categoryRepeat: CategoryRepeatEnum
  
  public init(defaultKey: String, title: String, order: Int, categoryRepeat: CategoryRepeatEnum) {
    self.defaultKey = defaultKey
    self.title = title
    self.order = order
    self.categoryRepeat = categoryRepeat
  }
}
