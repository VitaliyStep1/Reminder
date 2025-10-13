//
//  PreviewDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

import Foundation
import ReminderPersistence

public final class PreviewDataService: PreviewDataServiceProtocol, @unchecked Sendable {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol
  
  private var eventForPreviewData: (title: String, comment: String) {
    (title: "Event 1", comment: "Comment 1")
  }
  
  public required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
  }
  
  public func takeFirstCategoryIdentifier() async throws -> ObjectId? {
    try? await dBCategoriesService.takeFirstCategoryIdentifier()
  }
  
  public func addDataForPreview() async throws {
    try await createEventIfNecessary()
  }
  
  private func createEventIfNecessary() async throws {
    let eventData = eventForPreviewData
    let eventTitle = eventData.title
    let eventComment = eventData.comment
    let eventDate = Date()
    
    if let categoryId = try? await dBCategoriesService.takeFirstCategoryIdentifier() {
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
