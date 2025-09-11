//
//  AppDependencies.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine

class AppDependencies: ObservableObject {
  let persistenceService = PersistenceService.shared
  
  lazy var databaseService: DatabaseServiceProtocol = DatabaseService(container: persistenceService.container)
  lazy var dataService: DataServiceProtocol = DataService(databaseService: self.databaseService, defaultCategoriesDataService: self.defaultCategoriesDataService)
  lazy var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol = DefaultCategoriesDataService()
}
