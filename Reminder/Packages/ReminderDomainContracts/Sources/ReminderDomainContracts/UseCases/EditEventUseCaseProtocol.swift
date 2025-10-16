//
//  EditEventUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created as part of Clean Architecture refactor.
//

import Foundation

public protocol EditEventUseCaseProtocol: Sendable {
  func execute(eventId: Identifier, title: String, date: Date, comment: String) async throws
}
