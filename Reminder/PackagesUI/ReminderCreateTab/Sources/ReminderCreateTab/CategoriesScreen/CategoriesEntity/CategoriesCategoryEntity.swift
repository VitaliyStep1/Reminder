//
//  CategoriesCategoryEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import ReminderDomain

struct CategoriesCategoryEntity: Identifiable, Hashable {
  let id: Identifier
  let title: String
  let eventsAmount: String
  
  init(category: ReminderDomain.Category) {
    self.id = category.id
    self.title = category.title
    self.eventsAmount = String(category.eventsAmount)
  }
}
