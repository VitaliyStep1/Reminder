//
//  CategoryLocalizationManager.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 28.11.2025.
//

import Foundation

// Note. Localization of Domain should be moved outside ReminderDomain

public class CategoryLocalizationManager {
  public static let shared = CategoryLocalizationManager()
  private init() {}
  
  lazy var categoryTitleEnumDict: [String: CategoryTitleEnum] = {
    var dict: [String: CategoryTitleEnum] = [:]
    for value in CategoryTitleEnum.allCases {
      dict[value.rawValue] = value
    }
    return dict
  }()
  
  public func localize(categoryTitle: String, locale: Locale) -> String {
    guard let categoryTitleEnum = categoryTitleEnumDict[categoryTitle] else {
      return categoryTitle
    }
    var resource = categoryTitleEnum.localizedStringResource
    resource.locale = locale
    return String(localized: resource)
  }
}
