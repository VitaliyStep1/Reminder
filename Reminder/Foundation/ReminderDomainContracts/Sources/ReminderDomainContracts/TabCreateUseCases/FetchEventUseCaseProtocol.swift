//
//  FetchEventUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created as part of Clean Architecture refactor.
//

import Foundation

public protocol FetchEventUseCaseProtocol: Sendable {
  func execute(eventId: Identifier) async throws -> Event
}
