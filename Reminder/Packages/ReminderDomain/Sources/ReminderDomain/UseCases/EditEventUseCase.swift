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

  public init(dBEventsService: DBEventsServiceProtocol) {
    self.dBEventsService = dBEventsService
  }

  public func execute(eventId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dBEventsService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
  }
}
