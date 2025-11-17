//
//  TextEnum.swift
//  ReminderDomain
//
//  Created by OpenAI's assistant.
//

import Foundation

enum TextEnum: String {
  case categoryBirthdaysTitle
  case categorySubscriptionsTitle
  case categoryUtilitiesTitle
  case categoryAniversariesTitle
  case categoryOtherEveryYearTitle
  case categoryOtherEveryMonthTitle
  case categoryOtherEveryDayTitle
  case categoryOtherOneTimeTitle
  case previewEventTitle
  case previewEventComment

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
