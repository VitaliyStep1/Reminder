//
//  EventSectionContainer.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventSectionContainer<Content: View>: View {
  let title: String
  let systemImageName: String
  let contentBuilder: () -> Content
  
  init(title: String, systemImageName: String, @ViewBuilder contentBuilder: @escaping () -> Content) {
    self.title = title
    self.systemImageName = systemImageName
    self.contentBuilder = contentBuilder
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Label(title, systemImage: systemImageName)
        .font(.dsTitle3Semibold)
        .foregroundStyle(.primary)
      contentBuilder()
    }
    .padding(20)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(.ultraThinMaterial)
    )
    .overlay(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .stroke(DSColor.Text.primary.opacity(0.08))
    )
    .dsShadow()
  }
}
