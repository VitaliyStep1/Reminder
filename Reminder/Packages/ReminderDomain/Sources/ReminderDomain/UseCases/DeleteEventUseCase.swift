//
//  DeleteEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct DeleteEventUseCase: DeleteEventUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(eventId: Identifier) async throws {
    try await dataService.deleteEvent(eventId: eventId)
  }
}
