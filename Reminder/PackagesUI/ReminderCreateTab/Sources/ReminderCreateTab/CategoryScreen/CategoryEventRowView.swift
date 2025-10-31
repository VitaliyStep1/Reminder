//
//  CategoryEventCellView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import SwiftUI

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
      .contentShape(Rectangle())
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

#Preview {
  CategoryEventRowView(title: "Title", dateString: "1.01.2001", tapAction: { })
}
