//
//  DependencyAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 07.10.2025.
//

import Swinject
import CoreData
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
    
    // PersistenceContainerService
    container.register(PersistenceContainerService.self) { _ in
      PersistenceContainerService()
    }
    .inObjectScope(.container)
    
    // NSPersistentContainer - NOT in memory
    container.register(NSPersistentContainer.self) { r in
      let factory = r.resolve(PersistenceContainerService.self)!
      let persistentContainer = factory.createPersistentContainer(inMemory: false)
      return persistentContainer
    }
    .inObjectScope(.container)
    
    // DBCategoriesServiceProtocol
    container.register(DBCategoriesServiceProtocol.self) { r in
      let persistentContainer = r.resolve(NSPersistentContainer.self)!
      return DBCategoriesService(container: persistentContainer)
    }
    .inObjectScope(.container)
    
    // DBEventsServiceProtocol
    container.register(DBEventsServiceProtocol.self) { r in
      let persistentContainer = r.resolve(NSPersistentContainer.self)!
      return DBEventsService(container: persistentContainer)
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
      guard
        let defaultCategoriesDataService = resolver.resolve(DefaultCategoriesDataServiceProtocol.self)
      else {
#if DEBUG
        fatalError("PreviewDataService deps not resolved.")
#else
        return nil
#endif
      }
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
