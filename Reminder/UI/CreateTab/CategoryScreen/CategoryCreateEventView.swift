//
//  CategoryCreateEventView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI

struct CategoryCreateEventView: View {
  @Binding var title: String
  @Binding var date: Date
  @Binding var comment: String
  
  var createButtonAction: (() -> Void)?
  var cancelButtonAction: (() -> Void)?
  
  var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      
      VStack(spacing: 16) {
        Text("Create Event")
          .font(.headline)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("Title:")
          TextField("Title", text: $title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          
          HStack {
            Spacer()
            DatePicker("", selection: $date, displayedComponents: [.date])
              .datePickerStyle(.wheel)
              .labelsHidden()
            Spacer()
          }
          
          Text("Comment:")
          TextField("Comment", text: $comment)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        Button(action: {
          createButtonAction?()
        }) {
          Text("Create")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        Button(action: {
          cancelButtonAction?()
        }) {
          Text("Cancel")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.gray)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
      }
      .padding()
      .frame(maxWidth: 400)
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(radius: 10)
    }
  }
}

#Preview {
  CategoryCreateEventView(
    title: .constant("Sample Title"),
    date: .constant(Date()),
    comment: .constant("Sample Comment"),
    createButtonAction: { print("Create tapped") },
    cancelButtonAction: { print("Cancel tapped") }
  )
}
