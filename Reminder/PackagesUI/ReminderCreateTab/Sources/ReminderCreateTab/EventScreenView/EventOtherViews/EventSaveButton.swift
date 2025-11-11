//
//  EventSaveButton.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 10.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventSaveButton: View {
  let buttonTappedAction: () -> Void
  let title: String
  let isProgressViewVisible: Bool
  
  init(buttonTappedAction: @escaping () -> Void, title: String, isProgressViewVisible: Bool) {
    self.buttonTappedAction = buttonTappedAction
    self.title = title
    self.isProgressViewVisible = isProgressViewVisible
  }
  
  var body: some View {
    Button(action: {
      buttonTappedAction()
    }) {
      HStack(spacing: 10) {
        if isProgressViewVisible {
          ProgressView()
            .tint(ReminderColor.Text.inverse)
          Text(title)
        } else {
          Image(systemName: "checkmark.circle.fill")
          Text(title)
        }
      }
      .font(.headline)
      .frame(maxWidth: .infinity, minHeight: 50)
      .padding(.horizontal, 4)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(
            LinearGradient(
              colors: [ReminderColor.Accent.gradientStart, ReminderColor.Accent.gradientStrong],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
      )
      .foregroundStyle(ReminderColor.Text.inverse)
      .shadow(color: ReminderColor.Accent.shadowSoft, radius: 10, x: 0, y: 6)
    }
  }
}
