//
//  CategoryEventCellView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import SwiftUI
import ReminderDesignSystem

public struct CategoryEventRowView: View {
  var title: String
  var dateString: String
  let tapAction: () -> Void
  
  public var body: some View {
    Button {
      tapAction()
    } label: {
      VStack(alignment: .leading, spacing: DSSpacing.s4) {
        HStack {
          Text(title)
            .font(.dsHeadline)
          Spacer()
          Text(dateString)
            .font(.dsSubheadline)
            .monospacedDigit()
            .foregroundStyle(.secondary)
        }
      }
      .dsCellBackground()
    }
    .buttonStyle(.plain)
    .dsShadow(.r8Medium)
  }
}

#Preview {
  CategoryEventRowView(title: "Title", dateString: "1.01.2001", tapAction: { })
}
