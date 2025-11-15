//
//  CreateCoordinator.swift
//  ReminderNavigation
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderCreateTab
import ReminderResolver

@MainActor
public final class CreateCoordinator: CreateCoordinatorProtocol {
  private let resolver: Resolver
  private let router: any CreateTabRouterProtocol

  public init(resolver: Resolver) {
    self.resolver = resolver
    self.router = resolver.createTabRouterProtocol
  }

  public func start() -> AnyView {
    let fetchAllCategoriesUseCase = resolver.fetchAllCategoriesUseCaseProtocol
    let viewModel = CategoriesViewModel(fetchAllCategoriesUseCase: fetchAllCategoriesUseCase, router: router)
    let view = CategoriesScreenView(viewModel: viewModel, coordinator: self)
    return AnyView(view)
  }

  public func destination(for route: Route) -> AnyView {
    switch route {
    case .category(let categoryId):
      let viewModel = CategoryViewModel(
        categoryId: categoryId,
        fetchEventsUseCase: resolver.fetchEventsUseCaseProtocol,
        fetchCategoryUseCase: resolver.fetchCategoryUseCaseProtocol,
        router: router
      )
      let view = CategoryScreenView(viewModel: viewModel)
      return AnyView(view)
    case .event(let eventScreenViewType):
      let store = EventViewStore(eventScreenViewType: eventScreenViewType, router: router)
      let presenter = EventPresenter(store: store)
      let interactor = EventInteractor(
        createEventUseCase: resolver.createEventUseCaseProtocol,
        editEventUseCase: resolver.editEventUseCaseProtocol,
        deleteEventUseCase: resolver.deleteEventUseCaseProtocol,
        fetchEventUseCase: resolver.fetchEventUseCaseProtocol,
        fetchCategoryUseCase: resolver.fetchCategoryUseCaseProtocol,
        fetchDefaultRemindTimeDateUseCase: resolver.fetchDefaultRemindTimeDateUseCaseProtocol,
        presenter: presenter,
        store: store
      )
      let view = EventScreenView(store: store, interactor: interactor)
      return AnyView(view)
    default:
      return AnyView(EmptyView())
    }
  }
}
