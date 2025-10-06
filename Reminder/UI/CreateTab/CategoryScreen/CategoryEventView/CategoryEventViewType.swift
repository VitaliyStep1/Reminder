//
//  CategoryEventViewType.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.09.2025.
//

enum CategoryEventViewType: Equatable, Hashable {
  case create(categoryId: ObjectId)
  case edit(eventId: ObjectId)
  case notVisible
}
