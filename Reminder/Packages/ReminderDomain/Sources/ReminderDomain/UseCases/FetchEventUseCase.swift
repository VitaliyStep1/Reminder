//
//  FetchEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct FetchEventUseCase: FetchEventUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(eventId: Identifier) async throws -> Event {
    try await dataService.fetchEvent(eventId: eventId)
  }
}
