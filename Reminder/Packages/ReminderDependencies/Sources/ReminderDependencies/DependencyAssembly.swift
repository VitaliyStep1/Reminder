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
import ReminderMainTabViewContracts

final class DependencyAssembly: Assembly {
  
  func assemble(container: Container) {
    // ViewFactory
    container.register(ViewFactoryProtocol.self) { r in
      ViewFactory(resolver: r)
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
    
    // Use Cases
    container.register(SetupInitialDataUseCaseProtocol.self) { resolver in
      let defaultCategoriesDataService = resolver.defaultCategoriesDataServiceProtocol
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      return SetupInitialDataUseCase(
        defaultCategoriesDataService: defaultCategoriesDataService,
        dBCategoriesService: dBCategoriesService
      )
    }
    .inObjectScope(.container)
    
    container.register(FetchAllCategoriesUseCaseProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      return FetchAllCategoriesUseCase(dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)
    
    container.register(FetchCategoryUseCaseProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      return FetchCategoryUseCase(dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)
    
    container.register(FetchEventsUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.dbEventsServiceProtocol
      return FetchEventsUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
    
    container.register(FetchEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.dbEventsServiceProtocol
      return FetchEventUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
    
    container.register(CreateEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.dbEventsServiceProtocol
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      return CreateEventUseCase(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)
    
    container.register(EditEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.dbEventsServiceProtocol
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      return EditEventUseCase(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)
    
    container.register(DeleteEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.dbEventsServiceProtocol
      return DeleteEventUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
    
    // PreviewDataServiceProtocol
    container.register(PreviewDataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      let dBEventsService = resolver.dbEventsServiceProtocol
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
    
    // SplashScreenState
    container.register(SplashScreenState.self) { _ in
      SplashScreenState()
    }
    .inObjectScope(.container)
    
    // SplashScreenState
    container.register(MainTabViewSelectionState.self) { _ in
      MainTabViewSelectionState(selection: .closest)
    }
    .inObjectScope(.container)
  }
}
