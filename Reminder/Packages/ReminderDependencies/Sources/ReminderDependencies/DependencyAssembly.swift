//
//  DependencyAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 07.10.2025.
//

import Swinject
import ReminderPersistenceContracts
import ReminderPersistence
import ReminderDomainContracts
import ReminderDomain
import ReminderNavigation
import ReminderStartUI
import ReminderConfigurations
import ReminderNavigationContracts
import ReminderResolver

final class DependencyAssembly: Assembly {
  
  func assemble(container: Container) {
    // ViewFactory
    container.register(ViewFactoryProtocol.self) { r in
      ViewFactory(resolver: r)
    }
    .inObjectScope(.container)
    
    // SplashScreenState
    container.register(SplashScreenState.self) { _ in
      SplashScreenState()
    }
    .inObjectScope(.container)
    
    // AppConfigurationProtocol
    container.register(AppConfigurationProtocol.self) { _ in
      AppConfiguration()
    }
    .inObjectScope(.container)
    
    // DefaultCategoriesDataServiceProtocol
    container.register(DefaultCategoriesDataServiceProtocol.self) { _ in
      DefaultCategoriesDataService()
    }
    .inObjectScope(.container)
    
    // DataServiceProtocol
    container.register(DataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      let dBEventsService = resolver.dbEventsServiceProtocol
      let defaultCategoriesDataService = resolver.defaultCategoriesDataServiceProtocol
      return DataService(
        dBCategoriesService: dBCategoriesService,
        dBEventsService: dBEventsService,
        defaultCategoriesDataService: defaultCategoriesDataService
      )
    }
    .inObjectScope(.container)
    
    // PreviewDataServiceProtocol
    container.register(PreviewDataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      let dBEventsService = resolver.dbEventsServiceProtocol
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
  }
}
