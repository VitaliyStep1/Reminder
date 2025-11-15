//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderSharedUI

public struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel
  @Environment(\.viewFactory) var viewFactory
  
  public init(viewModel: CategoriesViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack(path: routerPathBinding) {
      contentView
        .frame(maxWidth: .infinity)
        .sharedScreenPadding()
        .sharedScreenBackground()
        .task {
          viewModel.taskWasCalled()
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationDestination(for: Route.self) { route in
          destinationView(for: route)
        }
    }
  }
}

private extension CategoriesScreenView {
  var routerPathBinding: Binding<[Route]> {
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
      SharedNoDataView(systemImageName: "square.grid.2x2", title: title)
      Spacer()
    }
  }
  
  @ViewBuilder
  func destinationView(for route: Route) -> some View {
    if let viewFactory {
      switch route {
      case .category, .event:
        viewFactory.make(route)
      default:
        EmptyView()
      }
    } else {
      EmptyView()
    }
  }
}

