//
//  SettingsScreenView.swift
//  ReminderSettingsTab
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import SwiftUI
import ReminderSharedUI

public struct SettingsScreenView: View {
  @StateObject var viewModel: SettingsViewModel
  
  public init(viewModel: SettingsViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack {
      contentView
        .sharedScreenPadding()
        .sharedScreenBackground()
        .navigationTitle("Settings")
    }
  }
  
  var contentView: some View {
    ScrollView {
      VStack {
        VStack {
          DatePicker(
            "Default remind time:",
            selection: $viewModel.defaultRemindTimeDate,
            displayedComponents: .hourAndMinute
          )
          .datePickerStyle(.compact)
          .sharedCellBackground()
          .sharedShadow()
          HStack {
            Text("Choose a default reminder time for events.")
              .padding(.horizontal, 16)
            Spacer()
          }
        }
        Spacer()
      }
    }
  }
}
