//
//  CreateEventUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct CreateEventUseCase: CreateEventUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(categoryId: Identifier, title: String, date: Date, comment: String) async throws {
    try await dataService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
}
