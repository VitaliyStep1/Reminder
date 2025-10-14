//
//  CategoryEventViewType.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.09.2025.
//

import ReminderDomain

public enum CategoryEventViewType: Equatable, Hashable {
  case create(categoryId: Identifier)
  case edit(eventId: Identifier)
  case notVisible
}
