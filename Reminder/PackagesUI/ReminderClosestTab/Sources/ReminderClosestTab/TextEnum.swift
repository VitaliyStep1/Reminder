//
//  TextEnum.swift
//  ReminderClosestTab
//
//  Created by Vitaliy Stepanenko on 17.11.2025.
//

import Foundation

enum TextEnum: String {
  case closestScreenTitle
  case closestCreateEventButtonTitle
  case closestNoEventsText
  
  var localized: String {
    NSLocalizedString(rawValue, bundle: .module, comment: "")
  }
}
