//
//  TextEnum.swift
//  ReminderStartUI
//
//  Created by OpenAI Assistant on 18.11.2025.
//

import Foundation

enum TextEnum: String {
  case splashTitle

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
