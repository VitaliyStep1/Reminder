//
//  PreviewDataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

import ReminderPersistence

public protocol PreviewDataServiceProtocol: Sendable {
  init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService:DBEventsServiceProtocol)
  
  func takeFirstCategoryIdentifier() async throws -> Identifier?
  func addDataForPreview() async throws
}
