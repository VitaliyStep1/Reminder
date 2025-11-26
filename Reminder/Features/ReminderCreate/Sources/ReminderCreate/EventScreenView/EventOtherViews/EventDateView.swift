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
      HStack(spacing: DSSpacing.s8) {
        VStack(alignment: .leading, spacing: DSSpacing.s4) {
          Text(TextEnum.eventDateLabel.localized)
            .font(.dsHeadline)
            .foregroundStyle(DSColor.Text.primary)
          Text(eventDateFormatter.string(from: eventDate))
            .font(.dsSubheadline)
            .foregroundStyle(DSColor.Text.secondary)
        }
        Spacer()
        Image(systemName: "calendar")
          .font(.dsTitle3)
          .padding(DSSpacing.s10)
          .background(
            Circle()
              .fill(DSColor.Fill.accentO_12)
          )
          .foregroundStyle(DSColor.Icon.accent)
          .dsShadow(.r10AccentSoft)
      }
      .padding(.horizontal, DSSpacing.s20)
      .padding(.vertical, DSSpacing.s16)
      .background {
        RoundedRectangle(cornerRadius: DSRadius.r12)
          .fill(DSColor.Background.primary)
          .dsShadow(.r6Light)
      }
    }
    .sheet(isPresented: $isDateDatePickerVisible) {
      datePickerSheetView()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
  }
  
  private func datePickerSheetView() -> some View {
    VStack(spacing: DSSpacing.s24) {
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
        .padding(.vertical, DSSpacing.s8)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: DSRadius.r16, style: .continuous)
            .fill(DSColor.Background.secondary)
        )
        .padding(.horizontal)

      HStack(spacing: DSSpacing.s16) {
        Button {
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.cancelTitle.localized)
            .font(.dsHeadline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, DSSpacing.s12)
            .background(
              RoundedRectangle(cornerRadius: DSRadius.r12, style: .continuous)
                .stroke(DSColor.Stroke.secondary, lineWidth: 1)
            )
        }

        Button {
          eventDate = temporaryEventDate
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.doneTitle.localized)
            .font(.dsHeadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, DSSpacing.s12)
            .background(
              RoundedRectangle(cornerRadius: DSRadius.r12, style: .continuous)
                .fill(DSColor.Fill.accent)
            )
            .foregroundStyle(DSColor.Text.white)
        }
        
      }
      .padding(.horizontal)
    }
    .padding(.horizontal, DSSpacing.s8)
    .padding(.vertical, DSSpacing.s8)
    .frame(maxWidth: .infinity)
    .background(DSColor.Background.primary)
  }
}
