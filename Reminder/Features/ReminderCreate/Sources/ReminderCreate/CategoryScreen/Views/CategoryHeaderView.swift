//
//  CategoryHeaderView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct CategoryHeaderView: View {
  let title: String
  let subtitle: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(DSFont.titleLarge())
        .foregroundStyle(.primary)

      Text(subtitle)
        .font(DSFont.callout())
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
