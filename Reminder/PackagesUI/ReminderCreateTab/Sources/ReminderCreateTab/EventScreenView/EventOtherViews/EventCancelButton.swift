//
//  EventCancelButton.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 10.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventCancelButton: View {
  let buttonTappedAction: () -> Void
  let title: String
  
  init(buttonTappedAction: @escaping () -> Void, title: String) {
    self.buttonTappedAction = buttonTappedAction
    self.title = title
  }
  
  var body: some View {
    Button(action: {
      buttonTappedAction()
    }) {
      Text(title)
        .font(.headline)
        .frame(maxWidth: .infinity, minHeight: 50)
        .padding(.horizontal, 4)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(.ultraThinMaterial)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .stroke(ReminderColor.Text.secondary.opacity(0.2), lineWidth: 1)
        )
    }
  }
}
