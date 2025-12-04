//
//  CreateCoordinator.swift
//  ReminderCreateTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class CreateCoordinator: CreateCoordinatorProtocol {
  public let router: any CreateRouterProtocol
  
  private let categoriesScreenBuilder: CategoriesScreenBuilder
  private let categoryScreenBuilder: CategoryScreenBuilder
  private let eventScreenBuilder: EventScreenBuilder

  public init(
    router: any CreateRouterProtocol,
    categoriesScreenBuilder: @escaping CategoriesScreenBuilder,
    categoryScreenBuilder: @escaping CategoryScreenBuilder,
    eventScreenBuilder: @escaping EventScreenBuilder
  ) {
    self.router = router
    self.categoriesScreenBuilder = categoriesScreenBuilder
    self.categoryScreenBuilder = categoryScreenBuilder
    self.eventScreenBuilder = eventScreenBuilder
  }

  public func start() -> AnyView {
    let view = categoriesScreenBuilder()
    return AnyView(view)
  }

  public func destination(for route: CreateRoute) -> AnyView {
    switch route {
    case .category(let categoryId):
      let view = categoryScreenBuilder(categoryId)
      return AnyView(view)
    case .event(let eventScreenViewType):
      let view = eventScreenBuilder(eventScreenViewType)
      return AnyView(view)
    default:
      return AnyView(EmptyView())
    }
  }
  
  public func categoriesScreenCategoryWasClicked(categoryId: Identifier) {
    router.pushScreen(.category(categoryId))
  }
}
