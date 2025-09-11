//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel = .init()
  @EnvironmentObject var appDependencies: AppDependencies
  
  var body: some View {
    NavigationStack(path: $viewModel.path) {
      List {
        ForEach(viewModel.categoryEntities) { categoryEntity in
          Button {
            viewModel.categoryButtonClicked(categoryEntity)
          } label: {
            HStack {
              Text(categoryEntity.title)
              Spacer()
              Text(categoryEntity.eventsAmount)
            }
          }
        }
      }
      .task {
        viewModel.setupDataService(dataService: appDependencies.dataService)
      }
      .navigationTitle(viewModel.navigationTitle)
      .navigationDestination(for: CategoriesCategoryEntity.self) { categoryEntity in
        CategoryScreenView(viewModel: CategoryViewModel(categoryId: categoryEntity.id))
      }
    }
  }
}
