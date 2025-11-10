//
//  EventTextField.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventTextField: View {
  let placeholder: String
  @Binding var text: String
  
  init(placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    _text = text
  }
  
  var body: some View {
    TextField(placeholder, text: $text)
      .padding(.horizontal, 14)
      .padding(.vertical, 12)
      .background(fieldBackground)
      .overlay(
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .stroke(ReminderColor.Accent.primary.opacity(text.isEmpty ? 0 : 0.4), lineWidth: 1)
      )
  }
  
  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: 14, style: .continuous)
      .fill(ReminderColor.Background.primary.opacity(0.9))
      .shadow(color: ReminderColor.Shadow.extraLight, radius: 6, x: 0, y: 3)
  }
}
