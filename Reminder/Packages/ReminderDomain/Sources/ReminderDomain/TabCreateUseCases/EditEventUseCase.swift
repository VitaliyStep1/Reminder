//
//  EditEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct EditEventUseCase: EditEventUseCaseProtocol {
  private let dBEventsService: DBEventsServiceProtocol
  private let dBCategoriesService: DBCategoriesServiceProtocol
  
  public init(dBEventsService: DBEventsServiceProtocol, dBCategoriesService: DBCategoriesServiceProtocol) {
    self.dBEventsService = dBEventsService
    self.dBCategoriesService = dBCategoriesService
  }

  public func execute(
    eventId: Identifier,
    title: String,
    date: Date,
    comment: String,
    remindRepeat: RemindRepeatEnum
  ) async throws -> Identifier? {
    let calculateCategoryIdForEventService = CalculateCategoryIdForEventService(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    let newCategoryId = try await calculateCategoryIdForEventService.calculateNewCategoryIdForEditingEvent(eventId: eventId, remindRepeat: remindRepeat)
    try await dBEventsService.editEvent(
      eventId: eventId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat.rawValue,
      newCategoryId: newCategoryId
    )
    return newCategoryId
  }
    
}
