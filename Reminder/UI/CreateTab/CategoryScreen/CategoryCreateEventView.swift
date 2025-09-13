//
//  CategoryCreateEventView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI

struct CategoryCreateEventView: View {
  @Binding var title: String
  @Binding var comment: String
  
  var createButtonAction: (() -> Void)?
  
  var body: some View {
    ZStack {
      Color(.white)
      GeometryReader { geometry in
        VStack {
          Text("Create Event")
          Text("Title:")
          TextField("Title", text: $title)
          Text("Comment:")
          TextField("Comment", text: $comment)
          Button(action: {
            createButtonAction?()
          }) {
            Text("Create")
              .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
              .background(Color.blue)
              .foregroundStyle(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)
        }
        .background(Color.orange)
        .frame(width: geometry.size.width * 0.5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      }
    }
  }
}

//#Preview {
//  CategoryCreateEventView(title: .constant("Title 1"), comment: .constant("Comment 1"), createButtonAction: {})
//}
