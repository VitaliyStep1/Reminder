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
      .init(defaultKey: "Birthdays", title: "Birthdays", order: 1, categoryRepeat: .repeatEveryYear_notChoose),
      .init(defaultKey: "Subscriptions", title: "Subscriptions", order: 2, categoryRepeat: .repeatEveryMonth_notChoose),
      .init(defaultKey: "Utilities", title: "Utilities", order: 3, categoryRepeat: .repeatEveryMonth_notChoose),
      .init(defaultKey: "Aniversaries", title: "Aniversaries", order: 4, categoryRepeat: .repeatEveryYear_notChoose),
      .init(defaultKey: "Other_repeatEveryYear", title: "Other - repeat every year", order: 5, categoryRepeat: .repeatEveryYear_chooseAll),
      .init(defaultKey: "Other_repeatEveryMonth", title: "Other - repeat every month", order: 6, categoryRepeat: .repeatEveryMonth_chooseAll),
      .init(defaultKey: "Other_repeatEveryDay", title: "Other - repeat every day", order: 7, categoryRepeat: .repeatEveryDay_chooseAll),
      .init(defaultKey: "Other_notRepeat", title: "Other - not repeat", order: 8, categoryRepeat: .notRepeat_chooseAll),
    ]
    return categories
  }
}
