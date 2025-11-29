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
      .init(defaultKey: "Birthdays", title: CategoryTitleEnum.categoryBirthdaysTitle.rawValue, order: 1, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .birthdays),
      .init(defaultKey: "Subscriptions", title: CategoryTitleEnum.categorySubscriptionsTitle.rawValue, order: 2, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .subscriptions),
      .init(defaultKey: "Utilities", title: CategoryTitleEnum.categoryUtilitiesTitle.rawValue, order: 3, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .utilities),
      .init(defaultKey: "Aniversaries", title: CategoryTitleEnum.categoryAniversariesTitle.rawValue, order: 4, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .aniversaries),
      .init(defaultKey: "Other_repeatEveryYear", title: CategoryTitleEnum.categoryOtherEveryYearTitle.rawValue, order: 5, categoryRepeat: .repeatEveryYear_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_repeatEveryMonth", title: CategoryTitleEnum.categoryOtherEveryMonthTitle.rawValue, order: 6, categoryRepeat: .repeatEveryMonth_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_repeatEveryDay", title: CategoryTitleEnum.categoryOtherEveryDayTitle.rawValue, order: 7, categoryRepeat: .repeatEveryDay_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_notRepeat", title: CategoryTitleEnum.categoryOtherOneTimeTitle.rawValue, order: 8, categoryRepeat: .notRepeat_chooseAll, categoryGroup: .other),
    ]
    return categories
  }
}
