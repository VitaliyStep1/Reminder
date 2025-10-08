//
//  CategoryEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

import ReminderPersistence

enum CategoryEntity {
  struct Event: Identifiable {
    let id: ObjectId
    let title: String
    let date: String
    let comment: String?
  }
}
