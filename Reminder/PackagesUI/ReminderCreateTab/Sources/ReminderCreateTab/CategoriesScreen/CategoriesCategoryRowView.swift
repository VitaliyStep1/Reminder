//
//  CategoriesCategoryRowView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 30.10.2025.
//

import SwiftUI
import ReminderSharedUI

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
          .fill(ReminderColor.Background.groupedSecondary)
      }
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    .buttonStyle(.plain)
    .shadow(color: ReminderColor.Shadow.heavy, radius: 4, x: 0, y: 3)
  }
}
