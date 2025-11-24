//
//  PreviewDataService.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public final class PreviewDataService: PreviewDataServiceProtocol, @unchecked Sendable {
  private var dBCategoriesService: DBCategoriesServiceProtocol
  private var dBEventsService: DBEventsServiceProtocol

  private var eventForPreviewData: (title: String, comment: String) {
    (
      title: TextEnum.previewEventTitle.localized,
      comment: TextEnum.previewEventComment.localized
    )
  }
  
  public required init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService: DBEventsServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
    self.dBEventsService = dBEventsService
  }
  
  public func takeFirstCategoryIdentifier() async throws -> Identifier? {
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
    let remindRepeat = RemindRepeatEnum.everyYear.rawValue
    let remindTimeDate1 = Date()
    let remindTimeDate2: Date? = nil
    let remindTimeDate3: Date? = nil
    
    if let categoryId = try? await dBCategoriesService.takeFirstCategoryIdentifier() {
      let isNecessaryToCreateEvent = try await !isEventsExist(categoryId: categoryId)
      if isNecessaryToCreateEvent {
        try await dBEventsService.createEvent(
          categoryId: categoryId,
          title: eventTitle,
          date: eventDate,
          comment: eventComment,
          remindRepeat: remindRepeat,
          remindTimeDate1: remindTimeDate1,
          remindTimeDate2: remindTimeDate2,
          remindTimeDate3: remindTimeDate3
        )
      }
    }
  }
  
  private func isEventsExist(categoryId: Identifier) async throws -> Bool {
    let events = try await dBEventsService.fetchEvents(categoryId: categoryId)
    return !events.isEmpty
  }
}
