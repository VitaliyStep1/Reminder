//
//  DataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

protocol DataServiceProtocol {
  init(databaseService: DatabaseServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol)
  func setupDataAtStart()
  
  func takeAllCategories() async -> [Category]?
  func takeAllEvents() -> [Event]
}
