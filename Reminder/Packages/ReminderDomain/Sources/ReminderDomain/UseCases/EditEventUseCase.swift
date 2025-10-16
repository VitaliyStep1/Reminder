//
//  EditEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct EditEventUseCase: EditEventUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(eventId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dataService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
  }
}
