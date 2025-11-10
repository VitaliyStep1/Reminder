//
//  EventSubSectionContainer.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI

struct EventSubSectionContainer<Content: View>: View {
  let title: String
  let contentBuilder: () -> Content
  
  init(title: String, @ViewBuilder contentBuilder: @escaping () -> Content) {
    self.title = title
    self.contentBuilder = contentBuilder
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(.secondary)
      contentBuilder()
    }
  }
}
