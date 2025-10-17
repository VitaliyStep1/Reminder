//
//  SetupInitialDataUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created as part of Clean Architecture refactor.
//

import Foundation

public protocol SetupInitialDataUseCaseProtocol: Sendable {
  func execute() async
}
