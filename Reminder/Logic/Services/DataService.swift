//
//  DataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

class DataService: DataServiceProtocol {
  func takeAllCategories() -> [Category] {
    let allCategories: [Category] = [
      .init(id: 1, title: "Birthdays", order: 1),
      .init(id: 2, title: "Subscriptions", order: 2),
      .init(id: 3, title: "Utilities", order: 3),
      .init(id: 4, title: "Aniversaries", order: 4),
      .init(id: 5, title: "Other", order: 5),
    ]
    return allCategories
  }
  
  func takeAllEvents() -> [Event] {
    return []
  }
}
