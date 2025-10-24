//
//  SettingsViewModel.swift
//  ReminderSettingsTab
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation

@MainActor
public final class SettingsViewModel: ObservableObject {
  @Published public var remindTimeDate: Date

  public init(remindTimeDate: Date = Date()) {
    self.remindTimeDate = remindTimeDate
  }
}
