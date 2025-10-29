//
//  EventDateView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 27.10.2025.
//

import SwiftUI

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
      HStack {
        Text("Date:")
        Spacer()
        Text(eventDateFormatter.string(from: eventDate))
      }
      .foregroundStyle(.black)
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.secondary.opacity(0.4))
      }
    }
    .sheet(isPresented: $isDateDatePickerVisible) {
      datePickerSheetView()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
  }
  
  private func datePickerSheetView() -> some View {
    VStack {
      Text("Select event date, please")
      HStack {
        Button {
          isDateDatePickerVisible = false
        } label: {
          Text("Cancel")
            .foregroundStyle(.black)
            .padding(.all, 20)
        }
        Spacer()
        Button {
          eventDate = temporaryEventDate
          isDateDatePickerVisible = false
        } label: {
          Text("Done")
            .foregroundStyle(.black)
            .padding(.all, 20)
        }
      }
      HStack {
        Spacer()
        DatePicker("", selection: $temporaryEventDate, displayedComponents: [.date])
          .datePickerStyle(.wheel)
          .labelsHidden()
        Spacer()
      }
    }
  }
}
