//
//  StartFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import SwiftUI
import Swinject
import ReminderStart
import ReminderMainTabView
import ReminderConfigurations
import ReminderDomainContracts

@MainActor
struct StartFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(StartScreenViewModel.self) { r in
      let appConfiguration = r.resolve(AppConfigurationProtocol.self)!
      let setupInitialDataUseCase = r.resolve(SetupInitialDataUseCaseProtocol.self)!
      return StartScreenViewModel(appConfiguration: appConfiguration, setupInitialDataUseCase: setupInitialDataUseCase)
    }
    
    container.register(SplashScreenViewFactoryProtocol.self) { _ in
      SplashScreenViewFactory()
    }
    
    container.register(StartCoordinator.self) { r in
      let languageService = r.resolve(LanguageServiceProtocol.self)!
      let startScreenBuilder = r.resolve(StartScreenBuilder.self)!

      return StartCoordinator(startScreenBuilder: startScreenBuilder, languageService: languageService)
    }
    .inObjectScope(.container)

    container.register(StartScreenBuilder.self) { r in
      { splashState in
        let startScreenViewModel = r.resolve(StartScreenViewModel.self)!
        let splashScreenViewFactory = r.resolve(SplashScreenViewFactoryProtocol.self)!
        let mainCoordinator = r.resolve(MainCoordinator.self)!

        let splashViewBuilder: StartScreenView.ViewBuilder = {
          let binding = Binding(
            get: { splashState.isVisible },
            set: { splashState.isVisible = $0 }
          )
          return splashScreenViewFactory.makeSplashScreen(isVisible: binding)
        }

        return StartScreenView(
          viewModel: startScreenViewModel,
          splashViewBuilder: splashViewBuilder,
          mainViewBuilder: { [mainCoordinator] in
            mainCoordinator.start()
          }
        )
      }
    }

    container.register(AnyView.self, name: "RootView") { resolver in
      let coordinator = resolver.resolve(StartCoordinator.self)!
      return coordinator.start()
    }
    .inObjectScope(.container)
  }
}
