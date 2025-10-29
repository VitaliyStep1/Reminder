//
//  CategoriesCategoryEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import ReminderDomainContracts

struct CategoriesCategoryEntity: Identifiable, Hashable {
  let id: Identifier
  let title: String
  let eventsAmount: Int

  init(category: ReminderDomainContracts.Category) {
    self.id = category.id
    self.title = category.title
    self.eventsAmount = category.eventsAmount
  }
}
