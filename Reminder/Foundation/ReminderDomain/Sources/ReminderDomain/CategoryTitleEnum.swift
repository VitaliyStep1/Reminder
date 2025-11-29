//
//  CategoryTitleEnum.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 28.11.2025.
//

import Foundation

// Note. Localization of Domain should be moved outside ReminderDomain

enum CategoryTitleEnum: String, CaseIterable {
  case categoryBirthdaysTitle
  case categorySubscriptionsTitle
  case categoryUtilitiesTitle
  case categoryAniversariesTitle
  case categoryOtherEveryYearTitle
  case categoryOtherEveryMonthTitle
  case categoryOtherEveryDayTitle
  case categoryOtherOneTimeTitle
  
  var localizationValue: String.LocalizationValue {
    String.LocalizationValue(stringLiteral: self.rawValue)
  }
  
  var localizedStringResource: LocalizedStringResource {
    Localize.localizedResource(self.localizationValue)
  }
}
