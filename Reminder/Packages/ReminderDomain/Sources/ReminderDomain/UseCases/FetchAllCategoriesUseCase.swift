//
//  FetchAllCategoriesUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct FetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute() async throws -> [ReminderDomainContracts.Category] {
    try await dataService.takeAllCategories()
  }
}
