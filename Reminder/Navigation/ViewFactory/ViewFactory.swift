//
//  ViewFactory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import Swinject

struct ViewFactory {
  private let resolver: Resolver
  
  init(resolver: Resolver) {
    self.resolver = resolver
  }
  
  @MainActor @ViewBuilder
  func make(_ route: Route) -> some View {
    switch route {
    case .start:
      let appConfiguration = resolver.resolve(AppConfigurationProtocol.self)
      let dataService = resolver.resolve(DataServiceProtocol.self)
      let viewModel = StartScreenViewModel(appConfiguration: appConfiguration, dataService: dataService)
      let splashState = resolver.resolve(SplashScreenState.self)! // TODO: Remove "!"
      StartScreenView(viewModel: viewModel)
        .environmentObject(splashState)
    case .splash:
      let splashState = resolver.resolve(SplashScreenState.self)! // TODO: Remove "!"
      let binding = Binding(
        get: { splashState.isVisible },
        set: { splashState.isVisible = $0 }
      )
      SplashScreenView(isSplashScreenVisible: binding)
    case .categories:
      let dataService = resolver.resolve(DataServiceProtocol.self)
      let viewModel = CategoriesViewModel(dataService: dataService)
      CategoriesScreenView(viewModel: viewModel)
    case .category(let categoryId):
      let dataService = resolver.resolve(DataServiceProtocol.self)
      let viewModel = CategoryViewModel(categoryId: categoryId, dataService: dataService)
      CategoryScreenView(viewModel: viewModel)
    case .closest:
      let viewModel = ClosestViewModel()
      ClosestScreenView(viewModel: viewModel)
    }
  }
  
  @MainActor
  func makeCategoryEventView(
    categoryEventViewType: CategoryEventViewType,
    eventsWereChangedHandler: @escaping () -> Void,
    closeViewHandler: @escaping () -> Void
  ) -> some View {
    let dataService = resolver.resolve(DataServiceProtocol.self)
    let viewModel = CategoryEventViewModel(dataService: dataService, type: categoryEventViewType, eventsWereChangedHandler: eventsWereChangedHandler, closeViewHandler: closeViewHandler)
    return CategoryEventView(viewModel: viewModel)
  }
}
