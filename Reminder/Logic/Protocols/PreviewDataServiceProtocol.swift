//
//  PreviewDataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 16.09.2025.
//

protocol PreviewDataServiceProtocol {
  init(dBCategoriesService: DBCategoriesServiceProtocol, dBEventsService:DBEventsServiceProtocol)
  
  func takeFirstCategoryObjectId() async throws -> ObjectId?
  func addDataForPreview() async throws
}
