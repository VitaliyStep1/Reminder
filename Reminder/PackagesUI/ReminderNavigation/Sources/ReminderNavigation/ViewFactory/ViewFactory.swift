//
//  ViewFactory.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import Swinject
import ReminderResolver
import ReminderDomainContracts
import ReminderConfigurations
import ReminderStartUI
import ReminderMainTabView
import ReminderNavigationContracts
import ReminderCreateTab
import ReminderClosestTab
import ReminderSettingsTab

public class ViewFactory: @preconcurrency ViewFactoryProtocol {
  private let resolver: Resolver
  
  public nonisolated(unsafe) init(resolver: Resolver) {
    self.resolver = resolver
  }
  
  @MainActor
  public func make(_ route: Route) -> AnyView {
    let resultView: any View
    switch route {
    case .mainTabView:
      resultView = MainTabView()
        .environmentObject(resolver.mainTabViewSelectionState)
    case .start:
      let appConfiguration = resolver.appConfigurationProtocol
      let setupInitialDataUseCase = resolver.setupInitialDataUseCaseProtocol
      let viewModel = StartScreenViewModel(
        appConfiguration: appConfiguration,
        setupInitialDataUseCase: setupInitialDataUseCase
      )
      let splashState = resolver.splashScreenState
      resultView = StartScreenView(viewModel: viewModel)
        .environmentObject(splashState)
    case .splash:
      let splashState: SplashScreenState = resolver.splashScreenState
      let binding = Binding(
        get: { splashState.isVisible },
        set: { splashState.isVisible = $0 }
      )
      resultView = SplashScreenView(isSplashScreenVisible: binding)
    case .categories:
      let fetchAllCategoriesUseCase = resolver.fetchAllCategoriesUseCaseProtocol
      let viewModel = CategoriesViewModel(fetchAllCategoriesUseCase: fetchAllCategoriesUseCase)
      resultView = CategoriesScreenView(viewModel: viewModel)
    case .category(let categoryId):
      let fetchEventsUseCase = resolver.fetchEventsUseCaseProtocol
      let fetchCategoryUseCase = resolver.fetchCategoryUseCaseProtocol
      let viewModel = CategoryViewModel(
        categoryId: categoryId,
        fetchEventsUseCase: fetchEventsUseCase,
        fetchCategoryUseCase: fetchCategoryUseCase
      )
      resultView = CategoryScreenView(viewModel: viewModel)
    case .closest:
      let mainTabViewSelectionState = resolver.mainTabViewSelectionState
      let viewModel = ClosestViewModel(mainTabViewSelectionState: mainTabViewSelectionState)
      resultView = ClosestScreenView(viewModel: viewModel)
    case .settings:
      let viewModel = SettingsViewModel()
      resultView = SettingsScreenView(viewModel: viewModel)
    }
    return AnyView(resultView)
  }
  
  @MainActor
  public func makeCategoryEventView(
    categoryEventViewType: CategoryEventViewType,
    eventsWereChangedHandler: @escaping @Sendable (Identifier?) -> Void,
    closeViewHandler: @escaping @Sendable () -> Void
  ) -> AnyView {
    let store = CategoryEventViewStore(categoryEventViewType: categoryEventViewType)
    let presenter = CategoryEventPresenter(store: store)
    let interactor = CategoryEventInteractor(
      createEventUseCase: resolver.createEventUseCaseProtocol,
      editEventUseCase: resolver.editEventUseCaseProtocol,
      deleteEventUseCase: resolver.deleteEventUseCaseProtocol,
      fetchEventUseCase: resolver.fetchEventUseCaseProtocol,
      fetchCategoryUseCase: resolver.fetchCategoryUseCaseProtocol,
      presenter: presenter,
      store: store,
      eventsWereChangedHandler: eventsWereChangedHandler,
      closeViewHandler: closeViewHandler
    )
    return AnyView(CategoryEventView(store: store, interactor: interactor))
  }
}
