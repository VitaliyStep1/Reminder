//
//  FetchEventsUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct FetchEventsUseCase: FetchEventsUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(categoryId: Identifier) async throws -> [Event] {
    try await dataService.fetchEvents(categoryId: categoryId)
  }
}
