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
      .textFieldStyle(SharedMainTextFieldStyle(isTextNotEmpty: !text.isEmpty))
  }
}
