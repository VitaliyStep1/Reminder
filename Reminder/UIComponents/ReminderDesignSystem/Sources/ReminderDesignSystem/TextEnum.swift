//
//  TextEnum.swift
//  ReminderDesignSystem
//
//  Created by OpenAI Assistant on 18.11.2025.
//

import Foundation

enum TextEnum: String {
  case delete
  case cancel
  case error
  case ok

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
