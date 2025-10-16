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

    // Use Cases
    container.register(SetupInitialDataUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return SetupInitialDataUseCase(dataService: dataService)
    }
    .inObjectScope(.container)

    container.register(FetchAllCategoriesUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return FetchAllCategoriesUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(FetchCategoryUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return FetchCategoryUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(FetchEventsUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return FetchEventsUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(FetchEventUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return FetchEventUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(CreateEventUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return CreateEventUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(EditEventUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return EditEventUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    container.register(DeleteEventUseCaseProtocol.self) { resolver in
      let dataService = resolver.dataServiceProtocol
      return DeleteEventUseCase(dataService: dataService)
    }
    .inObjectScope(.transient)

    // PreviewDataServiceProtocol
    container.register(PreviewDataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.dbCategoriesServiceProtocol
      let dBEventsService = resolver.dbEventsServiceProtocol
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
  }
}
