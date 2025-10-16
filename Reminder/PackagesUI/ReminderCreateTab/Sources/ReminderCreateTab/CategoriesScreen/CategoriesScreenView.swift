//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts

public struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel
  @Environment(\.viewFactory) var viewFactory
  
  public init(viewModel: CategoriesViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
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
        viewModel.taskWasCalled()
      }
      .navigationTitle(viewModel.navigationTitle)
      .navigationDestination(for: CategoriesCategoryEntity.self) { categoryEntity in
        if let viewFactory {
          viewFactory.make(.category(categoryEntity.id))
        } else {
          EmptyView()
        }
      }
    }
  }
}

