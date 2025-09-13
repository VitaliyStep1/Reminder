//
//  AppDependencies.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine

class AppDependencies: ObservableObject {
  let persistenceService = PersistenceService.shared
  
  lazy var dBCategoriesService: DBCategoriesServiceProtocol = DBCategoriesService(container: persistenceService.container)
  lazy var dBEventsService: DBEventsServiceProtocol = DBEventsService(container: persistenceService.container)
  
  lazy var dataService: DataServiceProtocol = DataService(dBCategoriesService: self.dBCategoriesService, dBEventsService: self.dBEventsService, defaultCategoriesDataService: self.defaultCategoriesDataService)
  lazy var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol = DefaultCategoriesDataService()
}
