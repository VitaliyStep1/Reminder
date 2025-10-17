//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation

public struct Event: Sendable {
  public let id: ObjectId
  public let title: String
  public let date: Date
  public let comment: String
  public let categoryId: ObjectId?
  public let remindRepeat: Int

  public init(
    id: ObjectId,
    title: String,
    date: Date,
    comment: String,
    categoryId: ObjectId?,
    remindRepeat: Int
  ) {
    self.id = id
    self.title = title
    self.date = date
    self.comment = comment
    self.categoryId = categoryId
    self.remindRepeat = remindRepeat
  }
}
