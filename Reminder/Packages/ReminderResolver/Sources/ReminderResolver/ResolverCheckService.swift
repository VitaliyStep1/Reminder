//
//  ResolverCheckService.swift
//  ReminderResolver
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject

public class ResolverCheckService {
  public static func checkDependencies(resolver: Resolver) -> [Any] {
    let dependencies: [Any] = [
      resolver.dbCategoriesServiceProtocol,
      resolver.dbEventsServiceProtocol,
      resolver.setupInitialDataUseCaseProtocol,
      resolver.fetchAllCategoriesUseCaseProtocol,
      resolver.fetchCategoryUseCaseProtocol,
      resolver.fetchEventsUseCaseProtocol,
      resolver.fetchEventUseCaseProtocol,
      resolver.createEventUseCaseProtocol,
      resolver.editEventUseCaseProtocol,
      resolver.deleteEventUseCaseProtocol,
      resolver.takeDefaultRemindTimeDateUseCaseProtocol,
      resolver.updateDefaultRemindTimeDateUseCaseProtocol,
      resolver.defaultCategoriesDataServiceProtocol,
      resolver.appConfigurationProtocol,
      resolver.mainTabViewSelectionState,
      resolver.userDefaultsServiceProtocol,
      resolver.fetchDefaultRemindTimeDateUseCaseProtocol,
      resolver.defaultRemindTimeServiceProtocol,
    ]
    
    return dependencies
  }
}
