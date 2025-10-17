//
//  CreateEventUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created as part of Clean Architecture refactor.
//

import Foundation

public protocol CreateEventUseCaseProtocol: Sendable {
  func execute(
    categoryId: Identifier,
    title: String,
    date: Date,
    comment: String,
    remindRepeat: RemindRepeatEnum
  ) async throws
}
