//
//  ClosestCreateEventButton.swift
//  ReminderClosestTab
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct ClosestCreateEventButton: View {
  let systemImageName: String
  let title: String
  let action: () -> Void
  
  public init(systemImageName: String, title: String, action: @escaping () -> Void) {
    self.systemImageName = systemImageName
    self.title = title
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      Label(title, systemImage: systemImageName)
    }
    .buttonStyle(DSMainButtonStyle())
  }
}
