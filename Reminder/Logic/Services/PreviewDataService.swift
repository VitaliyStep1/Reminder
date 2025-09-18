//
//  PreviewDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

import Foundation

final class PreviewDataService: PreviewDataServiceProtocol {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  
  required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
  }
  
  func takeFirstCategoryObjectId() async throws -> ObjectId? {
    try? await dBCategoriesService.takeFirstCategoryObjectId()
  }
  
  func addDataForPreview() async throws {
    try await createEvent()
  }
  
  private func createEvent() async throws {
    if let categoryId = try? await dBCategoriesService.takeFirstCategoryObjectId() {
      try await dBEventsService.createEvent(categoryId: categoryId, title: "Event 1", date: Date(), comment: "Comment 1")
    }
  }
}
