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
    Text("SettingsScreenView")
  }
}
