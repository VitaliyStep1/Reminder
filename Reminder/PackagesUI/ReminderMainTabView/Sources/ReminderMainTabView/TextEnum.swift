//
//  TextEnum.swift
//  ReminderMainTabView
//
//  Created by OpenAI Assistant on 18.11.2025.
//

import Foundation

enum TextEnum: String {
  case closestTabTitle
  case createTabTitle
  case settingsTabTitle

  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
