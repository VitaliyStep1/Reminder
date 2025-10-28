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
      .navigationDestination(for: Route.self) { route in
        
        if let viewFactory {
          switch route {
          case .category:
            viewFactory.make(route)
          case .event:
            viewFactory.make(route)
          default:
            EmptyView()
          }
        }
        else {
          EmptyView()
        }
      }
    }
  }
}

private extension CategoriesScreenView {
  var routerPathBinding: Binding<NavigationPath> {
    Binding(
      get: { viewModel.routerPath },
      set: { viewModel.routerPath = $0 }
    )
  }
}

