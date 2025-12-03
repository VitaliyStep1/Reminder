//
//  StartCoordinator.swift
//  ReminderStartUI
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderClosest
import ReminderCreate
import ReminderMainTabView
import ReminderSettings
import ReminderStart
import ReminderMainTabViewContracts
import ReminderConfigurations
import ReminderDomainContracts

@MainActor
public final class StartCoordinator: CoordinatorProtocol {
  let mainCoordinator: MainCoordinator
  
  let splashState = SplashScreenState()
  
  let startScreenViewModel: StartScreenViewModel
  let languageService: LanguageServiceProtocol
  
  let splashScreenViewFactory: SplashScreenViewFactoryProtocol

  public init(startScreenViewModel: StartScreenViewModel, splashScreenViewFactory: SplashScreenViewFactoryProtocol, languageService: LanguageServiceProtocol, mainCoordinator: MainCoordinator) {
    self.startScreenViewModel = startScreenViewModel
    self.splashScreenViewFactory = splashScreenViewFactory
    self.languageService = languageService
    self.mainCoordinator = mainCoordinator
  }

  public func start() -> AnyView {

    let splashViewBuilder: StartScreenView.ViewBuilder = {
      let binding = Binding(
        get: { self.splashState.isVisible },
        set: { self.splashState.isVisible = $0 }
      )
      return AnyView(SplashScreenView(isSplashScreenVisible: binding))
      return self.splashScreenViewFactory.makeSplashScreen(isVisible: binding)
    }
    
    let startView = StartScreenView(
      viewModel: startScreenViewModel,
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
