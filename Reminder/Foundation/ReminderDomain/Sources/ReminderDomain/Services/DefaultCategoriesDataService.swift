//
//  DefaultCategoriesDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import ReminderDomainContracts

public final class DefaultCategoriesDataService: DefaultCategoriesDataServiceProtocol, Sendable {
  
  public init() { }
  
  public enum CategoryKeyEnum: String, CaseIterable {
    case Birthdays
    case Subscriptions
    case Utilities
    case Aniversaries
    case Other_repeatEveryYear
    case Other_repeatEveryMonth
    case Other_repeatEveryDay
    case Other_notRepeat
  }
  
  func category(key: CategoryKeyEnum, order: Int, categoryRepeat: CategoryRepeatEnum, categoryGroup: CategoryGroupEnum) -> ReminderDomainContracts.DefaultCategory {
    let defaultKey = key.rawValue
    let title = defaultKey
    return ReminderDomainContracts.DefaultCategory(defaultKey: defaultKey, title: title, order: order, categoryRepeat: categoryRepeat, categoryGroup: categoryGroup)
  }
  
  public func takeDefaultCategories() -> [ReminderDomainContracts.DefaultCategory] {
    let categories: [ReminderDomainContracts.DefaultCategory] = [
      category(key: .Birthdays, order: 1, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .birthdays),
      category(key: .Subscriptions, order: 2, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .subscriptions),
      category(key: .Utilities, order: 3, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .utilities),
      category(key: .Aniversaries, order: 4, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .aniversaries),
      category(key: .Other_repeatEveryYear, order: 5, categoryRepeat: .repeatEveryYear_chooseAll, categoryGroup: .other),
      category(key: .Other_repeatEveryMonth, order: 6, categoryRepeat: .repeatEveryMonth_chooseAll, categoryGroup: .other),
      category(key: .Other_repeatEveryDay, order: 7, categoryRepeat: .repeatEveryDay_chooseAll, categoryGroup: .other),
      category(key: .Other_notRepeat, order: 8, categoryRepeat: .notRepeat_chooseAll, categoryGroup: .other),
    ]
    return categories
  }
}
