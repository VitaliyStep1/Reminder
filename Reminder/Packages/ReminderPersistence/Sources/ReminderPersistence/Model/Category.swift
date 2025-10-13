//
//  Category.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation

public struct Category: Identifiable, Sendable {
  public let id: ObjectId
  public let defaultKey: String
  public var title: String
  public let order: Int
  public let isUserCreated: Bool
  public var eventsAmount: Int
}
