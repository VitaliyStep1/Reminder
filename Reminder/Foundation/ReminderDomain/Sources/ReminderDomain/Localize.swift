//
//  Localize.swift
//  ReminderDomain
//
//  Created by OpenAI Assistant on 28.11.2025.
//
import SwiftUI

// Note. Localization of Domain should be moved outside ReminderDomain

enum Localize {
  private static let bundleDescription: LocalizedStringResource.BundleDescription = .atURL(Bundle.module.bundleURL)
  static func localizedResource(_ localizationValue: String.LocalizationValue) -> LocalizedStringResource {
    .init(localizationValue, bundle: Localize.bundleDescription)
  }
  
  static var categoryBirthdaysTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryBirthdaysTitle.localizationValue) }
  static var categorySubscriptionsTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categorySubscriptionsTitle.localizationValue) }
  static var categoryUtilitiesTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryUtilitiesTitle.localizationValue) }
  static var categoryAniversariesTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryAniversariesTitle.localizationValue) }
  static var categoryOtherEveryYearTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryOtherEveryYearTitle.localizationValue) }
  static var categoryOtherEveryMonthTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryOtherEveryMonthTitle.localizationValue) }
  static var categoryOtherEveryDayTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryOtherEveryDayTitle.localizationValue) }
  static var categoryOtherOneTimeTitle: LocalizedStringResource { localizedResource(CategoryTitleEnum.categoryOtherOneTimeTitle.localizationValue) }
  static var previewEventTitle: LocalizedStringResource { localizedResource("previewEventTitle") }
  static var previewEventComment: LocalizedStringResource { localizedResource("previewEventComment") }
}
