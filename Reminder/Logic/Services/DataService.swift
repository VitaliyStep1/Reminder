//
//  DataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation

class DataService: DataServiceProtocol {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  private var defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol
  
  required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol, defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
    self.defaultCategoriesDataService = defaultCategoriesDataService
  }
  
  public func setupDataAtStart() {
    Task {
      let defaultCategories = defaultCategoriesDataService.takeDefaultCategories()
      try? await dBCategoriesService.addOrUpdate(defaultCategories: defaultCategories)
    }
  }
  
  func createEvent(categoryId: ObjectId, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
  
  func takeAllCategories() async -> [Category]? {
    let categories = try? await dBCategoriesService.fetchAllCategories()
    return categories
  }
  
  func fetchEvents(categoryId: ObjectId) async throws -> [Event] {
    let events = try await dBEventsService.fetchEvents(categoryId: categoryId)
    return events
  }
}
