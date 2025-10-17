//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation

public struct Event: Sendable {
  public let id: Identifier
  public let title: String
  public let date: Date
  public let comment: String
  public let categoryId: Identifier?
  public let remindRepeat: RemindRepeatEnum

  public init(
    id: Identifier,
    title: String,
    date: Date,
    comment: String,
    categoryId: Identifier?,
    remindRepeat: RemindRepeatEnum
  ) {
    self.id = id
    self.title = title
    self.date = date
    self.comment = comment
    self.categoryId = categoryId
    self.remindRepeat = remindRepeat
  }
}
