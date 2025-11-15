//
//  Untitled.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderDomainContracts

public enum Route: Hashable {
  case category(Identifier)
  case event(EventScreenViewType)
}
