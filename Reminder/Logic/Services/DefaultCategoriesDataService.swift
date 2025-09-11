//
//  DefaultCategoriesDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

class DefaultCategoriesDataService: DefaultCategoriesDataServiceProtocol {
  
  func takeDefaultCategories() -> [DefaultCategory] {
    let categories: [DefaultCategory] = [
      .init(defaultKey: "Birthdays", title: "Birthdays", order: 1, isUserCreated: false),
      .init(defaultKey: "Subscriptions", title: "Subscriptions", order: 2, isUserCreated: false),
      .init(defaultKey: "Utilities", title: "Utilities", order: 3, isUserCreated: false),
      .init(defaultKey: "Aniversaries", title: "Aniversaries", order: 4, isUserCreated: false),
      .init(defaultKey: "Other", title: "Other", order: 5, isUserCreated: false),
    ]
    return categories
  }
}
