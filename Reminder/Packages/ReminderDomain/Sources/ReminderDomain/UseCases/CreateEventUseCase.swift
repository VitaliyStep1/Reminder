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

  public init(dBEventsService: DBEventsServiceProtocol) {
    self.dBEventsService = dBEventsService
  }

  public func execute(categoryId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
}
