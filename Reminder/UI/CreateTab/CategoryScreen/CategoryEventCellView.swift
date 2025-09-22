//
//  CategoryEventCellView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import SwiftUI

public struct CategoryEventCellView: View {
  @State var title: String
  @State var dateString: String
  @State var comment: String?
  
  public var body: some View {
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
      if let comment = self.comment, !comment.isEmpty {
        Text(comment)
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
    }
    .contentShape(Rectangle())
  }
}
