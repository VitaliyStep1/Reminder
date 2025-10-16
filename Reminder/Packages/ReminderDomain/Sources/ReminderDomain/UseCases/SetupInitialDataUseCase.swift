//
//  SetupInitialDataUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct SetupInitialDataUseCase: SetupInitialDataUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute() async {
    await dataService.setupDataAtStart()
  }
}
