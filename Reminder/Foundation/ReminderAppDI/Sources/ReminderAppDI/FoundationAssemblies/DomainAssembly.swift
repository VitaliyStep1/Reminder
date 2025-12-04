//
//  DomainAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderDomainContracts
import ReminderDomain
import ReminderPersistenceContracts
import ReminderConfigurations

struct DomainAssembly: Assembly {
  func assemble(container: Container) {

    container.register(DefaultCategoriesDataServiceProtocol.self) { _ in
      DefaultCategoriesDataService()
    }
    .inObjectScope(.container)

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

    container.register(PreviewDataServiceProtocol.self) { resolver in
      let dBCategoriesService = resolver.resolve(DBCategoriesServiceProtocol.self)!
      let dBEventsService = resolver.resolve(DBEventsServiceProtocol.self)!
      return PreviewDataService(dBCategoriesService: dBCategoriesService, dBEventsService: dBEventsService)
    }
    .inObjectScope(.transient)
  }
}
