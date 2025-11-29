//
//  Localize.swift
//  ReminderClosest
//
//  Created by Vitaliy Stepanenko on 28.11.2025.
//
import SwiftUI

enum Localize {
  private static let bundleDescription: LocalizedStringResource.BundleDescription = .atURL(Bundle.module.bundleURL)
  private static func localizedResource(_ localizationValue: String.LocalizationValue) -> LocalizedStringResource {
    .init(localizationValue, bundle: Localize.bundleDescription)
  }
  
  static var closestScreenTitle: LocalizedStringResource {
    localizedResource("closestScreenTitle")
  }
  static var closestCreateEventButtonTitle: LocalizedStringResource {
    localizedResource("closestCreateEventButtonTitle")
  }
  static var closestNoEventsText: LocalizedStringResource {
    localizedResource("closestNoEventsText")
  }
}
