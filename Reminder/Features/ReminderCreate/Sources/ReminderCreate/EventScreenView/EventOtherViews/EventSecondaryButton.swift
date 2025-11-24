//
//  EventSecondaryButton.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 10.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventSecondaryButton: View {
  let action: () -> Void
  let title: String
  let imageName: String
  
  init(action: @escaping () -> Void, title: String, imageName: String) {
    self.action = action
    self.title = title
    self.imageName = imageName
  }
  
  var body: some View {
    Button(action: action) {
      Label(title, systemImage: imageName)
    }
    .buttonStyle(DSSecondaryButtonStyle())
  }
}
