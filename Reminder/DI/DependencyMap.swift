//
//  DependencyMap.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

import Swinject
import CoreData

struct DependencyMap {
  static func registerDependencies(container: Container, diService: DIService) {
    
    // ViewFactory
    container.register(ViewFactory.self) { _ in
      ViewFactory(resolver: diService)
    }
    
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
    
    // NSPersistentContainer - in memory
    container.register(NSPersistentContainer.self) { r in
      let factory = r.resolve(PersistenceContainerService.self)!
      let pc = factory.createPersistentContainer(inMemory: true)
      return pc
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
    container.register(DataServiceProtocol.self) { r in
      guard
        let dBCategoriesService = r.resolve(DBCategoriesServiceProtocol.self),
        let dBEventsService = r.resolve(DBEventsServiceProtocol.self),
        let defaultCategoriesDataService = r.resolve(DefaultCategoriesDataServiceProtocol.self)
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
    container.register(PreviewDataServiceProtocol.self) { r in
      guard
        let dBCategoriesService = r.resolve(DBCategoriesServiceProtocol.self),
        let dBEventsService = r.resolve(DBEventsServiceProtocol.self)
      else {
#if DEBUG
        fatalError("PreviewDataService deps not resolved.")
#else
        return nil
#endif
      }
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
  }
}
