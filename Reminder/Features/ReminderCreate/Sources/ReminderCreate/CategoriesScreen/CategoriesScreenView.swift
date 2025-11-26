//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDesignSystem

public struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel

  public init(viewModel: CategoriesViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack(path: routerPathBinding) {
      contentView
        .frame(maxWidth: .infinity)
        .dsScreenPadding()
        .dsScreenBackground()
        .task {
          viewModel.taskWasCalled()
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationDestination(for: CreateRoute.self) { route in
          destinationView(for: route)
        }
    }
  }
}

private extension CategoriesScreenView {
  var routerPathBinding: Binding<[CreateRoute]> {
    Binding(
      get: { viewModel.routerPath },
      set: { viewModel.routerPath = $0 }
    )
  }
  
  @ViewBuilder
  var contentView: some View {
    switch viewModel.screenStateEnum {
    case .empty(let title):
      emptyStateView(title: title)
    case .withCategories(let categories):
      categoriesView(categories: categories)
    }
  }
  
  private func categoriesView(categories: [CategoriesEntity.Category]) -> some View {
    ScrollView {
      LazyVStack(spacing: 14) {
        ForEach(categories) { category in
          CategoriesCategoryRowView(
            title: category.title,
            eventsAmountText: category.eventsAmountText,
            tapAction: {
              viewModel.categoryRowWasClicked(category)
            })
        }
      }
      .padding(.vertical, 4)
    }
  }
  
  private func emptyStateView(title: String) -> some View {
    VStack {
      Spacer()
      DSNoDataView(systemImageName: "square.grid.2x2", title: title)
      Spacer()
    }
  }
  
  @ViewBuilder
  func destinationView(for route: CreateRoute) -> some View {
    viewModel.coordinator.destination(for: route)
  }
}

