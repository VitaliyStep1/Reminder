//
//  FetchCategoryUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts

public struct FetchCategoryUseCase: FetchCategoryUseCaseProtocol {
  private let dataService: DataServiceProtocol

  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }

  public func execute(categoryId: Identifier) async throws -> ReminderDomainContracts.Category? {
    try await dataService.fetchCategory(categoryId: categoryId)
  }
}
