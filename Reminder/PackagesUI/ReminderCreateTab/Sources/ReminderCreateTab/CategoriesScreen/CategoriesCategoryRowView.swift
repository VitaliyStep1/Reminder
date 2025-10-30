//
//  CategoriesCategoryRowView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 30.10.2025.
//

import SwiftUI

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
          .font(.headline)
          .foregroundStyle(.primary)
        Spacer()
        Text(eventsAmountText)
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(16)
      .background {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color(.secondarySystemGroupedBackground))
      }
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    .buttonStyle(.plain)
    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
  }
}
