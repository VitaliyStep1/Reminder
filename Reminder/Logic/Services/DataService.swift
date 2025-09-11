//
//  DataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

class DataService: DataServiceProtocol {
  private var databaseService: DatabaseServiceProtocol
  private var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol
  
  required init(databaseService: DatabaseServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol) {
    self.databaseService = databaseService
    self.defaultCategoriesDataService = defaultCategoriesDataService
  }
  
  
  public func setupDataAtStart() {
    Task {
      let defaultCategories = defaultCategoriesDataService.takeDefaultCategories()
      try? await databaseService.addOrUpdate(defaultCategories: defaultCategories)
    }
  }
  
  func takeAllCategories() async -> [Category]? {
    let categories = try? await databaseService.fetchAllCategories()
    return categories
  }
  
  func takeAllEvents() -> [Event] {
    return []
  }
}
