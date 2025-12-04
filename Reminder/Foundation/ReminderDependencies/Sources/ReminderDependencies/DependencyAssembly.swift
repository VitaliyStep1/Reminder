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
import ReminderConfigurations
import ReminderMainTabViewContracts
import ReminderUserDefaultsStorage

final class DependencyAssembly: Assembly {
  
  func assemble(container: Container) {
    
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
      let defaultCategoriesDataService = resolver.resolve(DefaultCategoriesDataServiceProtocol.self)!
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      return SetupInitialDataUseCase(
        defaultCategoriesDataService: defaultCategoriesDataService,
        dBCategoriesService: dBCategoriesService
      )
    }
    .inObjectScope(.transient)

    container.register(FetchAllCategoriesUseCaseProtocol.self) { resolver in
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      return FetchAllCategoriesUseCase(dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)

    container.register(FetchCategoryUseCaseProtocol.self) { resolver in
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      return FetchCategoryUseCase(dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)

    container.register(FetchEventsUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      return FetchEventsUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)

    container.register(FetchEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      return FetchEventUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)

    container.register(CreateEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      return CreateEventUseCase(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)

    container.register(EditEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      return EditEventUseCase(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    }
    .inObjectScope(.transient)

    container.register(DeleteEventUseCaseProtocol.self) { resolver in
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      return DeleteEventUseCase(dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)

    container.register(TakeDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.resolve(DefaultRemindTimeServiceProtocol.self)!
      return TakeDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }
    .inObjectScope(.transient)

    container.register(UpdateDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      return UpdateDefaultRemindTimeDateUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(TakeSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      return TakeSettingsLanguageUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(UpdateSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      let languageService = resolver.resolve(LanguageServiceProtocol.self)!
      return UpdateSettingsLanguageUseCase(userDefaultsService: userDefaultsService, languageService: languageService)
    }
    .inObjectScope(.transient)

    container.register(FetchDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.resolve(DefaultRemindTimeServiceProtocol.self)!
      return FetchDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }

    // PreviewDataServiceProtocol
    container.register(PreviewDataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
    
    container.register(UserDefaultsServiceProtocol.self) { _ in
      UserDefaultsService()
    }
    .inObjectScope(.container)
    
    container.register(DefaultRemindTimeServiceProtocol.self) { resolver in
      let appConfiguration = resolver.resolve(AppConfigurationProtocol.self)!
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      
      return DefaultRemindTimeService(appConfiguration: appConfiguration, userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.container)
    
    container.register(LanguageServiceProtocol.self) { resolver in
      let takeSettingsLanguageUseCase = resolver.resolve(TakeSettingsLanguageUseCaseProtocol.self)!
      
      return LanguageService(takeSettingsLanguageUseCase: takeSettingsLanguageUseCase)
    }
    .inObjectScope(.container)
    
//    container.register(CreateRouterProtocol.self) { _ in
//      return CreateRouter()
//    }
//    .inObjectScope(.container)
  }
}
