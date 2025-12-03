//
//  StartFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import SwiftUI
import Swinject
import ReminderStart
import ReminderMainTabViewContracts
import ReminderClosest
import ReminderCreate
import ReminderSettings
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
      let startScreenViewModel = r.resolve(StartScreenViewModel.self)!
      let splashScreenViewFactory = r.resolve(SplashScreenViewFactoryProtocol.self)!
      let languageService = r.resolve(LanguageServiceProtocol.self)!
      let mainCoordinator = r.resolve(MainCoordinator.self)!
      
      return StartCoordinator(startScreenViewModel: startScreenViewModel, splashScreenViewFactory: splashScreenViewFactory, languageService: languageService, mainCoordinator: mainCoordinator)
    }
    .inObjectScope(.container)

    container.register(AnyView.self, name: "RootView") { resolver in
      let coordinator = resolver.resolve(StartCoordinator.self)!
      return coordinator.start()
    }
    .inObjectScope(.container)
  }
}
