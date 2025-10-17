//
//  FetchCategoryUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct FetchCategoryUseCase: FetchCategoryUseCaseProtocol {
  private let dBCategoriesService: DBCategoriesServiceProtocol

  public init(dBCategoriesService: DBCategoriesServiceProtocol) {
    self.dBCategoriesService = dBCategoriesService
  }

  public func execute(categoryId: Identifier) async throws -> ReminderDomainContracts.Category? {
    let category = try? await dBCategoriesService.fetchCategory(categoryId: categoryId)
    return category.flatMap { category in
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
