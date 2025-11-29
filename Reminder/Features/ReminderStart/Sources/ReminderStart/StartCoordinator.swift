//
//  StartCoordinator.swift
//  ReminderStartUI
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderClosest
import ReminderCreate
import ReminderMainTabView
import ReminderSettings
import ReminderStart
import ReminderResolver
import ReminderMainTabViewContracts

@MainActor
public final class StartCoordinator: CoordinatorProtocol {
  private let resolver: Resolver
  let mainTabViewSelectionState = MainTabViewSelectionState(selection: .closest)
  private lazy var closestCoordinator = ClosestCoordinator(mainTabViewSelectionState: mainTabViewSelectionState)
  private lazy var createCoordinator = CreateCoordinator(resolver: resolver)
  private lazy var settingsCoordinator = SettingsCoordinator(resolver: resolver)
  private lazy var mainCoordinator = MainCoordinator(
    mainTabViewSelectionState: mainTabViewSelectionState,
    closestCoordinator: closestCoordinator,
    createCoordinator: createCoordinator,
    settingsCoordinator: settingsCoordinator
  )
  
  let splashState = SplashScreenState()

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

    let splashViewBuilder: StartScreenView.ViewBuilder = {
      let binding = Binding(
        get: { self.splashState.isVisible },
        set: { self.splashState.isVisible = $0 }
      )
      return AnyView(SplashScreenView(isSplashScreenVisible: binding))
    }
    
    let languageService = resolver.languageServiceProtocol

    let startView = StartScreenView(
      viewModel: viewModel,
      splashViewBuilder: splashViewBuilder,
      mainViewBuilder: { [mainCoordinator] in
        mainCoordinator.start()
      }
    )
    .environmentObject(splashState)
    .environment(\.locale, languageService.locale)

    return AnyView(startView)
  }
}
