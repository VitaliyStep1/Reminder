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
  public let remindTimeDate1: Date
  public let remindTimeDate2: Date?
  public let remindTimeDate3: Date?

  public init(
    id: Identifier,
    title: String,
    date: Date,
    comment: String,
    categoryId: Identifier?,
    remindRepeat: RemindRepeatEnum,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  ) {
    self.id = id
    self.title = title
    self.date = date
    self.comment = comment
    self.categoryId = categoryId
    self.remindRepeat = remindRepeat
    self.remindTimeDate1 = remindTimeDate1
    self.remindTimeDate2 = remindTimeDate2
    self.remindTimeDate3 = remindTimeDate3
  }
}
