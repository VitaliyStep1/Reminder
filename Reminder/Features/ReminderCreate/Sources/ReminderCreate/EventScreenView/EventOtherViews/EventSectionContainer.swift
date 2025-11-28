//
//  EventSectionContainer.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventSectionContainer<Content: View>: View {
  let title: LocalizedStringResource
  let systemImageName: String
  let contentBuilder: () -> Content

  init(title: LocalizedStringResource, systemImageName: String, @ViewBuilder contentBuilder: @escaping () -> Content) {
    self.title = title
    self.systemImageName = systemImageName
    self.contentBuilder = contentBuilder
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: DSSpacing.s16) {
      Label(title: {
        Text(title)
      }, icon: {
        Image(systemName: systemImageName)
      })
        .font(.dsTitle3Semibold)
        .foregroundStyle(.primary)
      contentBuilder()
    }
    .padding(DSSpacing.s20)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: DSRadius.r24, style: .continuous)
        .fill(.ultraThinMaterial)
    )
    .overlay(
      RoundedRectangle(cornerRadius: DSRadius.r24, style: .continuous)
        .stroke(DSColor.Stroke.primaryO_08)
    )
    .dsShadow(.r12Heavy)
  }
}
