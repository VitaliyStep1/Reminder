//
//  PreviewDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

import Foundation
import ReminderPersistence

public  class PreviewDataService: PreviewDataServiceProtocol {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  
  private var eventForPreviewData: (title: String, comment: String) {
    (title: "Event 1", comment: "Comment 1")
  }
  
  public required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
  }
  
  public func takeFirstCategoryObjectId() async throws -> ObjectId? {
    try? await dBCategoriesService.takeFirstCategoryObjectId()
  }
  
  public func addDataForPreview() async throws {
    try await createEventIfNecessary()
  }
  
  private func createEventIfNecessary() async throws {
    let eventData = eventForPreviewData
    let eventTitle = eventData.title
    let eventComment = eventData.comment
    let eventDate = Date()
    
    if let categoryId = try? await dBCategoriesService.takeFirstCategoryObjectId() {
      let isNecessaryToCreateEvent = try await !isEventsExist(categoryId: categoryId)
      if isNecessaryToCreateEvent {
        try await dBEventsService.createEvent(categoryId: categoryId, title: eventTitle, date: eventDate, comment: eventComment)
      }
    }
  }
  
  private func isEventsExist(categoryId: ObjectId) async throws -> Bool {
    let events = try await dBEventsService.fetchEvents(categoryId: categoryId)
    return !events.isEmpty
  }
}
