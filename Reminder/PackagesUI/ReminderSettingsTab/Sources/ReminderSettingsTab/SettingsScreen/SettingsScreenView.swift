//
//  SettingsScreenView.swift
//  ReminderSettingsTab
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import SwiftUI

public struct SettingsScreenView: View {
  @StateObject var viewModel: SettingsViewModel

  public init(viewModel: SettingsViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    NavigationStack {
      Form {
        Section {
          DatePicker(
            "Default remind time:",
            selection: $viewModel.defaultRemindTimeDate,
            displayedComponents: .hourAndMinute
          )
          .datePickerStyle(.compact)
        } footer: {
          Text("Choose a default reminder time for events.")
        }
      }
      .navigationTitle("Settings")
    }
  }
}
