//
//  DefaultCategoriesDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import ReminderDomainContracts

public final class DefaultCategoriesDataService: DefaultCategoriesDataServiceProtocol, Sendable {
  
  public init() { }
  
  public func takeDefaultCategories() -> [ReminderDomainContracts.DefaultCategory] {
    let categories: [ReminderDomainContracts.DefaultCategory] = [
      .init(defaultKey: "Birthdays", title: "Birthdays", order: 1),
      .init(defaultKey: "Subscriptions", title: "Subscriptions", order: 2),
      .init(defaultKey: "Utilities", title: "Utilities", order: 3),
      .init(defaultKey: "Aniversaries", title: "Aniversaries", order: 4),
      .init(defaultKey: "Other", title: "Other", order: 5),
    ]
    return categories
  }
}
