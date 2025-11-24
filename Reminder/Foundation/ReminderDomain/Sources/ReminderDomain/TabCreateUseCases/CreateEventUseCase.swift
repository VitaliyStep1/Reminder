//
//  CreateEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct CreateEventUseCase: CreateEventUseCaseProtocol {
  private let dBEventsService: DBEventsServiceProtocol
  private let dBCategoriesService: DBCategoriesServiceProtocol

  public init(dBEventsService: DBEventsServiceProtocol, dBCategoriesService: DBCategoriesServiceProtocol) {
    self.dBEventsService = dBEventsService
    self.dBCategoriesService = dBCategoriesService
  }

  public func execute(
    categoryId: Identifier,
    title: String,
    date: Date,
    comment: String,
    remindRepeat: RemindRepeatEnum,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  ) async throws -> Identifier? {
    let calculateCategoryIdForEventService = CalculateCategoryIdForEventService(dBEventsService: dBEventsService, dBCategoriesService: dBCategoriesService)
    let newCategoryId = try await calculateCategoryIdForEventService.calculateNewCategoryIdForCreatingEvent(categoryId: categoryId, remindRepeat: remindRepeat)
    let resultCategoryId: Identifier = newCategoryId ?? categoryId
    
    try await dBEventsService.createEvent(
      categoryId: resultCategoryId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat.rawValue,
      remindTimeDate1: remindTimeDate1,
      remindTimeDate2: remindTimeDate2,
      remindTimeDate3: remindTimeDate3
    )
    return newCategoryId
  }
}
