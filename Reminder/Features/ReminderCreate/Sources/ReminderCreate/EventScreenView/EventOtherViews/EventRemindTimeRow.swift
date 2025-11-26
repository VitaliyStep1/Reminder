//
//  EventRemindTimeRow.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 10.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventRemindTimeRow: View {
  let title: String
  @Binding var selection: Date
  let removeAction: (() -> Void)?
  
  init(title: String, selection: Binding<Date>, removeAction: (() -> Void)? = nil) {
    self.title = title
    _selection = selection
    self.removeAction = removeAction
  }
  
  var body: some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .font(.dsSubheadlineSemibold)
          .foregroundStyle(.secondary)
        DatePicker(
          "",
          selection: $selection,
          displayedComponents: .hourAndMinute
        )
        .labelsHidden()
        .datePickerStyle(.compact)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      if let removeAction {
        Button(action: removeAction) {
          Image(systemName: "minus.circle.fill")
            .font(.dsTitle2)
            .foregroundStyle(DSColor.Danger.primary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Remove \(title)")
      }
    }
    .padding(.horizontal, 14)
    .padding(.vertical, 12)
    .background(fieldBackground)
    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
  }
  
  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: 14, style: .continuous)
      .fill(DSColor.Background.primary.opacity(0.9))
      .dsShadow()
  }
}
