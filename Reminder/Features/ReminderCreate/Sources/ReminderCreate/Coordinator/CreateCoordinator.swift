//
//  CreateCoordinator.swift
//  ReminderCreateTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderResolver
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class CreateCoordinator: CreateCoordinatorProtocol {
  private let resolver: Resolver
  private let categoriesViewModel: CategoriesViewModel
  public let router: any CreateRouterProtocol
  
  private let categoryScreenBuilder: CategoryScreenBuilder

  public init(
    resolver: Resolver,
    categoriesViewModel: CategoriesViewModel,
    router: any CreateRouterProtocol,
    categoryScreenBuilder: @escaping CategoryScreenBuilder
  ) {
    self.resolver = resolver
    self.categoriesViewModel = categoriesViewModel
    self.router = router
    self.categoryScreenBuilder = categoryScreenBuilder
  }

  public func start() -> AnyView {
    let view = CategoriesScreenView(viewModel: categoriesViewModel)
    return AnyView(view)
  }

  public func destination(for route: CreateRoute) -> AnyView {
    switch route {
    case .category(let categoryId):
      let view = categoryScreenBuilder(categoryId)
      return AnyView(view)
    case .event(let eventScreenViewType):
      let store = resolver.resolve(EventViewStore.self, argument: eventScreenViewType)!
      let presenter = resolver.resolve(EventPresenter.self, argument: store)!
      let interactor = resolver.resolve(EventInteractor.self, arguments: store, presenter)!
      let view = EventScreenView(store: store, interactor: interactor)
      return AnyView(view)
    default:
      return AnyView(EmptyView())
    }
  }
  
  public func categoriesScreenCategoryWasClicked(categoryId: Identifier) {
    router.pushScreen(.category(categoryId))
  }
}
