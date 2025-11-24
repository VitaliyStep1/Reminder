//
//  EventDateView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 27.10.2025.
//

import SwiftUI
import ReminderSharedUI

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
            .font(.headline)
            .foregroundStyle(.primary)
          Text(eventDateFormatter.string(from: eventDate))
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        Spacer()
        Image(systemName: "calendar")
          .font(.title3)
          .padding(10)
          .background(
            Circle()
              .fill(SharedColor.Accent.highlight)
          )
          .foregroundStyle(SharedColor.Accent.primary)
      }
      .foregroundStyle(SharedColor.Text.primary)
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
      .background {
        RoundedRectangle(cornerRadius: 12)
          .fill(SharedColor.Background.primary)
          .sharedShadowLight()
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
          .font(.title3)
          .fontWeight(.semibold)
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
            .fill(SharedColor.Background.secondary)
        )
        .padding(.horizontal)

      HStack(spacing: 16) {
        Button {
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.cancelTitle.localized)
            .font(.headline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
              RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(SharedColor.Text.secondary, lineWidth: 1)
            )
        }

        Button {
          eventDate = temporaryEventDate
          isDateDatePickerVisible = false
        } label: {
          Text(TextEnum.doneTitle.localized)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
              RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(SharedColor.Accent.primary)
            )
            .foregroundStyle(SharedColor.Text.inverse)
        }
        
      }
      .padding(.horizontal)
    }
    .padding(.horizontal, 8)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(SharedColor.Background.primary)
  }
}
