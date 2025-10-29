//
//  FetchEventsUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct FetchEventsUseCase: FetchEventsUseCaseProtocol {
  private let dBEventsService: DBEventsServiceProtocol

  public init(dBEventsService: DBEventsServiceProtocol) {
    self.dBEventsService = dBEventsService
  }

  public func execute(categoryId: Identifier) async throws -> [ReminderDomainContracts.Event] {
    let events = try await dBEventsService.fetchEvents(categoryId: categoryId)
    return events.map { event in
      ReminderDomainContracts.Event(
        id: event.id,
        title: event.title,
        date: event.date,
        comment: event.comment,
        categoryId: event.categoryId,
        remindRepeat: RemindRepeatEnum(fromRawValue: event.remindRepeat),
        remindTimeDate1: event.remindTimeDate1,
        remindTimeDate2: event.remindTimeDate2,
        remindTimeDate3: event.remindTimeDate3
      )
    }
  }
}
