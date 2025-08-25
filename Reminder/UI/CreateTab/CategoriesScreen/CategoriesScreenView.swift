//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel = .init()
  @State private var path: [CategoriesCategoryEntity] = []
  
  var body: some View {
    NavigationStack(path: $path) {
      List {
        ForEach(viewModel.categoryEntities) { categoryEntity in
          Button {
            path.append(categoryEntity)
          } label: {
            HStack {
              Text(categoryEntity.title)
              Spacer()
              Text(categoryEntity.eventsAmount)
            }
          }
        }
      }
      .navigationTitle(viewModel.navigationTitle)
      .navigationDestination(for: CategoriesCategoryEntity.self) { categoryEntity in
        CategoryScreenView(viewModel: CategoryViewModel(categoryId: categoryEntity.id))
      }
    }
  }
}
