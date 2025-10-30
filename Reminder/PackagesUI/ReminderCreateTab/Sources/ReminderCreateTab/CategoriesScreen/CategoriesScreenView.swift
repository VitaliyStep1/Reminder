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
      ZStack {
        BackgroundSharedView()
        contentView
          .padding(.horizontal, 16)
          .padding(.bottom, 24)
          .padding(.top, 8)
      }
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
    VStack(spacing: 12) {
      Image(systemName: "square.grid.2x2")
        .font(.system(size: 42, weight: .medium))
        .foregroundStyle(Color.blue)
      Text(title)
        .font(.headline)
    }
    .frame(maxWidth: .infinity)
    .padding(32)
    .background {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color(.secondarySystemGroupedBackground))
    }
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
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

