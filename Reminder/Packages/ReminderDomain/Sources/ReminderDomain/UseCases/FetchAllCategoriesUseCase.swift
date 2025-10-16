//
//  FetchAllCategoriesUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct FetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol {
  private let dBCategoriesService: DBCategoriesServiceProtocol

  public init(dBCategoriesService: DBCategoriesServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
  }

  public func execute() async throws -> [ReminderDomainContracts.Category] {
    let categories = try await dBCategoriesService.fetchAllCategories()
    return categories.map { category in
      ReminderDomainContracts.Category(
        id: category.id,
        defaultKey: category.defaultKey,
        title: category.title,
        order: category.order,
        isUserCreated: category.isUserCreated,
        eventsAmount: category.eventsAmount
      )
    }
  }
}
