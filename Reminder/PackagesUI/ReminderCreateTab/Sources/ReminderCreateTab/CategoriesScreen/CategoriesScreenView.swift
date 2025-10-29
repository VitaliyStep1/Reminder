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
    NavigationStack(path: routerPathBinding) {
      ZStack {
        backgroundGradient
        content
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        .padding(.top, 8)
      }
      .task {
        viewModel.taskWasCalled()
      }
      .navigationTitle(viewModel.navigationTitle)
      .navigationDestination(for: Route.self) { route in
        destination(for: route)
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

  var backgroundGradient: some View {
    LinearGradient(
      gradient: Gradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemBackground)]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea()
  }

  @ViewBuilder
  var content: some View {
    if viewModel.categoryEntities.isEmpty {
      emptyState
    } else {
      ScrollView {
        LazyVStack(spacing: 14) {
          ForEach(viewModel.categoryEntities) { categoryEntity in
            Button {
              viewModel.categoryButtonClicked(categoryEntity)
            } label: {
              CategoryRowView(
                title: categoryEntity.title,
                eventsAmount: categoryEntity.eventsAmount
              )
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(16)
              .background(cardBackground)
              .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
          }
        }
        .padding(.vertical, 4)
      }
    }
  }

  var cardBackground: some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
      .fill(Color(.secondarySystemGroupedBackground))
  }

  var emptyState: some View {
    VStack(spacing: 12) {
      Image(systemName: "square.grid.2x2")
        .font(.system(size: 42, weight: .medium))
        .foregroundStyle(Color.blue)
      Text("No categories yet")
        .font(.headline)
      Text("Create a reminder to see it organized by category.")
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity)
    .padding(32)
    .background(cardBackground)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
  }

  @ViewBuilder
  func destination(for route: Route) -> some View {
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

private struct CategoryRowView: View {
  let title: String
  let eventsAmount: Int

  var body: some View {
    HStack(spacing: 8) {
      Text(title)
        .font(.headline)
        .foregroundStyle(.primary)
      Spacer()
      Text("\(eventsAmount) event\(eventsAmount == 1 ? "" : "s")")
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
}

