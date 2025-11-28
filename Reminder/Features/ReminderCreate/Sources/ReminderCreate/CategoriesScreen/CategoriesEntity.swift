//
//  CategoriesEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import ReminderDomainContracts

enum CategoriesEntity {
  struct Category: Identifiable, Hashable {
    let id: Identifier
    let title: String
    let eventsAmountText: String
    
    init(id: Identifier, title: String, eventsAmountText: String) {
      self.id = id
      self.title = title
      self.eventsAmountText = eventsAmountText
    }
  }
  
  enum ScreenStateEnum {
    case empty(title: LocalizedStringResource)
    case withCategories(categories: [CategoriesEntity.Category])
  }
}
