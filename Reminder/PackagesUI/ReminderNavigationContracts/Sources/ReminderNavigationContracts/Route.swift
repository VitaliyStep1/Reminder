//
//  Untitled.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderDomain

public enum Route: Hashable {
  case mainTabView
  case start
  case splash
  case categories
  case category(Identifier)
  case closest
}
