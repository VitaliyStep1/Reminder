//
//  EventDateView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 27.10.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventDateView: View {
  @State private var isDateDatePickerVisible = false
  @State private var temporaryEventDate = Date()
  @Binding var eventDate: Date
  
  private let eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
  }()
  
  init(eventDate: Binding<Date>) {
    self._eventDate = eventDate
  }
  
  var body: some View {
    Button {
      temporaryEventDate = eventDate
      isDateDatePickerVisible = true
    } label: {
      HStack(spacing: 8) {
        VStack(alignment: .leading, spacing: 4) {
          Text(TextEnum.eventDateLabel.localized)
            .font(.dsHeadline)
            .foregroundStyle(.primary)
          Text(eventDateFormatter.string(from: eventDate))
            .font(.dsSubheadline)
            .foregroundStyle(.secondary)
        }
        Spacer()
        Image(systemName: "calendar")
          .font(.dsTitle3)
          .padding(10)
          .background(
            Circle()
              .fill(DSColor.Accent.highlight)
          )
          .foregroundStyle(DSColor.Accent.primary)
      }
      .foregroundStyle(DSColor.Text.primary)
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .background {
        RoundedRectangle(cornerRadius: 12)
          .fill(DSColor.Background.primary)
          .dsShadowLight()
      }
    }
    .sheet(isPresented: $isDateDatePickerVisible) {
      datePickerSheetView()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
  }
  
  private func datePickerSheetView() -> some View {
    VStack(spacing: 24) {
      HStack {
        Spacer()
        Text(TextEnum.selectEventDateTitle.localized)
          .font(.dsTitle3Semibold)
          .foregroundStyle(.primary)
        Spacer()
      }

      DatePicker("", selection: $temporaryEventDate, displayedComponents: [.date])
        .datePickerStyle(.wheel)
        .labelsHidden()
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(DSColor.Background.secondary)
        )
        .padding(.horizontal)

      HStack(spacing: 16) {
        Button {
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.cancelTitle.localized)
            .font(.dsHeadline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
              RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(DSColor.Text.secondary, lineWidth: 1)
            )
        }

        Button {
          eventDate = temporaryEventDate
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.doneTitle.localized)
            .font(.dsHeadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
              RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(DSColor.Accent.primary)
            )
            .foregroundStyle(DSColor.Text.inverse)
        }
        
      }
      .padding(.horizontal)
    }
    .padding(.horizontal, 8)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(DSColor.Background.primary)
  }
}
