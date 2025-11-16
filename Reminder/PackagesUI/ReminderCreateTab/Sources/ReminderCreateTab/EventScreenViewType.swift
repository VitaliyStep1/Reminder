//
//  EventScreenViewType.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.09.2025.
//

import ReminderDomainContracts

public enum EventScreenViewType: Equatable, Hashable {
  case create(categoryId: Identifier)
  case edit(eventId: Identifier)
  case notVisible
}
