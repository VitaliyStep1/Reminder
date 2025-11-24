//
//  CategoryEventCellView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import SwiftUI
import ReminderSharedUI

public struct CategoryEventRowView: View {
  var title: String
  var dateString: String
  let tapAction: () -> Void
  
  public var body: some View {
    Button {
      tapAction()
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        HStack {
          Text(title)
            .font(.headline)
          Spacer()
          Text(dateString)
            .font(.subheadline)
            .monospacedDigit()
            .foregroundStyle(.secondary)
        }
      }
      .sharedCellBackground()
    }
    .buttonStyle(.plain)
    .sharedShadow()
  }
}

#Preview {
  CategoryEventRowView(title: "Title", dateString: "1.01.2001", tapAction: { })
}
