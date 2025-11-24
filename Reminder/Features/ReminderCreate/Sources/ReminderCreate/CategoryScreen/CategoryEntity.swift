//
//  CategoryEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

import ReminderDomainContracts

enum CategoryEntity {
  struct Event: Identifiable {
    let id: Identifier
    let title: String
    let date: String
  }
  
  enum ScreenStateEnum {
    case empty(title: String)
    case withEvents(events: [CategoryEntity.Event])
  }
}
