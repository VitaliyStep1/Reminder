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
}
