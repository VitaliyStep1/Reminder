//
//  Localize.swift
//  ReminderDomain
//
//  Created by OpenAI Assistant on 28.11.2025.
//
import SwiftUI

enum Localize {
  private static let bundleDescription: LocalizedStringResource.BundleDescription = .atURL(Bundle.module.bundleURL)
  private static func localizedResource(_ localizationValue: String.LocalizationValue) -> LocalizedStringResource {
    .init(localizationValue, bundle: Localize.bundleDescription)
  }

  static var categoryBirthdaysTitle: LocalizedStringResource { localizedResource("categoryBirthdaysTitle") }
  static var categorySubscriptionsTitle: LocalizedStringResource { localizedResource("categorySubscriptionsTitle") }
  static var categoryUtilitiesTitle: LocalizedStringResource { localizedResource("categoryUtilitiesTitle") }
  static var categoryAniversariesTitle: LocalizedStringResource { localizedResource("categoryAniversariesTitle") }
  static var categoryOtherEveryYearTitle: LocalizedStringResource { localizedResource("categoryOtherEveryYearTitle") }
  static var categoryOtherEveryMonthTitle: LocalizedStringResource { localizedResource("categoryOtherEveryMonthTitle") }
  static var categoryOtherEveryDayTitle: LocalizedStringResource { localizedResource("categoryOtherEveryDayTitle") }
  static var categoryOtherOneTimeTitle: LocalizedStringResource { localizedResource("categoryOtherOneTimeTitle") }
  static var previewEventTitle: LocalizedStringResource { localizedResource("previewEventTitle") }
  static var previewEventComment: LocalizedStringResource { localizedResource("previewEventComment") }
}
