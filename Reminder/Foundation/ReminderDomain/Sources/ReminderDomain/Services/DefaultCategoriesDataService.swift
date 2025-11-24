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
      .init(defaultKey: "Birthdays", title: TextEnum.categoryBirthdaysTitle.localized, order: 1, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .birthdays),
      .init(defaultKey: "Subscriptions", title: TextEnum.categorySubscriptionsTitle.localized, order: 2, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .subscriptions),
      .init(defaultKey: "Utilities", title: TextEnum.categoryUtilitiesTitle.localized, order: 3, categoryRepeat: .repeatEveryMonth_notChoose, categoryGroup: .utilities),
      .init(defaultKey: "Aniversaries", title: TextEnum.categoryAniversariesTitle.localized, order: 4, categoryRepeat: .repeatEveryYear_notChoose, categoryGroup: .aniversaries),
      .init(defaultKey: "Other_repeatEveryYear", title: TextEnum.categoryOtherEveryYearTitle.localized, order: 5, categoryRepeat: .repeatEveryYear_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_repeatEveryMonth", title: TextEnum.categoryOtherEveryMonthTitle.localized, order: 6, categoryRepeat: .repeatEveryMonth_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_repeatEveryDay", title: TextEnum.categoryOtherEveryDayTitle.localized, order: 7, categoryRepeat: .repeatEveryDay_chooseAll, categoryGroup: .other),
      .init(defaultKey: "Other_notRepeat", title: TextEnum.categoryOtherOneTimeTitle.localized, order: 8, categoryRepeat: .notRepeat_chooseAll, categoryGroup: .other),
    ]
    return categories
  }
}
