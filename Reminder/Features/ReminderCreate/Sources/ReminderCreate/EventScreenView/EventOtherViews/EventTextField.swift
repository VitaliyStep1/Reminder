//
//  EventTextField.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventTextField: View {
  let placeholder: LocalizedStringResource
  @Binding var text: String

  init(placeholder: LocalizedStringResource, text: Binding<String>) {
    self.placeholder = placeholder
    _text = text
  }
  
  var body: some View {
    let placeholderString = String(localized: placeholder)
    TextField(placeholderString, text: $text)
      .textFieldStyle(DSMainTextFieldStyle(isTextNotEmpty: !text.isEmpty))
  }
}
