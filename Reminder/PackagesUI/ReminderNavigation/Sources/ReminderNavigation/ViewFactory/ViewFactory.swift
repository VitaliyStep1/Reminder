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
import ReminderNavigationContracts

@MainActor
public class ViewFactory: @preconcurrency ViewFactoryProtocol {
  private let resolver: Resolver
  private lazy var closestCoordinator = ClosestCoordinator(resolver: resolver)
  private lazy var createCoordinator = CreateCoordinator(resolver: resolver)
  private lazy var settingsCoordinator = SettingsCoordinator(resolver: resolver)
  private lazy var mainCoordinator = MainCoordinator(
    resolver: resolver,
    closestCoordinator: closestCoordinator,
    createCoordinator: createCoordinator,
    settingsCoordinator: settingsCoordinator
  )

  public nonisolated(unsafe) init(resolver: Resolver) {
    self.resolver = resolver
  }

  @MainActor
  public func make(_ route: Route) -> AnyView {
    let resultView: AnyView
    switch route {
    case .mainTabView:
      resultView = mainCoordinator.start()
    case .start:
      let appConfiguration = resolver.appConfigurationProtocol
      let setupInitialDataUseCase = resolver.setupInitialDataUseCaseProtocol
      let viewModel = StartScreenViewModel(
        appConfiguration: appConfiguration,
        setupInitialDataUseCase: setupInitialDataUseCase
      )
      let splashState = resolver.splashScreenState
      resultView = AnyView(
        StartScreenView(viewModel: viewModel)
          .environmentObject(splashState)
      )
    case .splash:
      let splashState: SplashScreenState = resolver.splashScreenState
      let binding = Binding(
        get: { splashState.isVisible },
        set: { splashState.isVisible = $0 }
      )
      resultView = AnyView(SplashScreenView(isSplashScreenVisible: binding))
    case .categories:
      resultView = createCoordinator.start()
    case .category, .event:
      resultView = createCoordinator.destination(for: route)
    case .closest:
      resultView = closestCoordinator.start()
    case .settings:
      resultView = settingsCoordinator.start()
    }
    return resultView
  }
}
