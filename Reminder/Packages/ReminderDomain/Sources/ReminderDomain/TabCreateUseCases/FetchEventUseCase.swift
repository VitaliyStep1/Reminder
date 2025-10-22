//
//  FetchEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct FetchEventUseCase: FetchEventUseCaseProtocol {
  private let dBEventsService: DBEventsServiceProtocol

  public init(dBEventsService: DBEventsServiceProtocol) {
    self.dBEventsService = dBEventsService
  }

  public func execute(eventId: Identifier) async throws -> ReminderDomainContracts.Event {
    let event = try await dBEventsService.fetchEvent(eventId: eventId)
    return ReminderDomainContracts.Event(
      id: event.id,
      title: event.title,
      date: event.date,
      comment: event.comment,
      categoryId: event.categoryId,
      remindRepeat: RemindRepeatEnum(fromRawValue: event.remindRepeat)
    )
  }
}
