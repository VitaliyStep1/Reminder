//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel = .init()
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.categoryEntities) { categoryEntity in
          HStack {
            Text(categoryEntity.title)
            Spacer()
            Text(categoryEntity.eventsAmount)
          }
        }
      }
      .navigationTitle(viewModel.navigationTitle)
    }
  }
}
