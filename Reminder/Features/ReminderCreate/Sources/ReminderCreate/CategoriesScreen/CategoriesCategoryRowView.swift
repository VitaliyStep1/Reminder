//
//  CategoriesCategoryRowView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 30.10.2025.
//

import SwiftUI
import ReminderDesignSystem

struct CategoriesCategoryRowView: View {
  let title: String
  let eventsAmountText: String
  let tapAction: () -> Void
  
  var body: some View {
    Button {
      tapAction()
    } label: {
      HStack(spacing: 8) {
        Text(title)
          .font(DSFont.headline())
          .foregroundStyle(.primary)
        Spacer()
        Text(eventsAmountText)
          .font(DSFont.subheadline())
          .foregroundStyle(.secondary)
      }
      .dsCellBackground()
    }
    .buttonStyle(.plain)
    .dsShadow()
  }
}
