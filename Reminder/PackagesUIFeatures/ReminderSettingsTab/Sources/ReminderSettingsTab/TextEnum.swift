//
//  TextEnum.swift
//  ReminderSettingsTab
//
//  Created by OpenAI Assistant on 18.11.2025.
//

import Foundation

enum TextEnum: String {
  case settingsTitle
  case defaultRemindTimeLabel
  case defaultRemindTimeDescription

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
