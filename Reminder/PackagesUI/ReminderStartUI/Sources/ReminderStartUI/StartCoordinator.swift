//
//  StartCoordinator.swift
//  ReminderStartUI
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderClosestTab
import ReminderCreateTab
import ReminderMainTabView
import ReminderSettingsTab
import ReminderStartUI
import ReminderResolver

@MainActor
public final class StartCoordinator: CoordinatorProtocol {
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

  public func start() -> AnyView {
    let appConfiguration = resolver.appConfigurationProtocol
    let setupInitialDataUseCase = resolver.setupInitialDataUseCaseProtocol
    let viewModel = StartScreenViewModel(
      appConfiguration: appConfiguration,
      setupInitialDataUseCase: setupInitialDataUseCase
    )

    let splashState = SplashScreenState()

    let splashViewBuilder: StartScreenView.ViewBuilder = {
      let binding = Binding(
        get: { splashState.isVisible },
        set: { splashState.isVisible = $0 }
      )
      return AnyView(SplashScreenView(isSplashScreenVisible: binding))
    }

    let startView = StartScreenView(
      viewModel: viewModel,
      splashViewBuilder: splashViewBuilder,
      mainViewBuilder: { [mainCoordinator] in
        mainCoordinator.start()
      }
    )
    .environmentObject(splashState)

    return AnyView(startView)
  }
}
