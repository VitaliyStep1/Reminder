//
//  SetupInitialDataUseCase.swift
//  ReminderDomain
//
//  Created as part of Clean Architecture refactor.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

public struct SetupInitialDataUseCase: SetupInitialDataUseCaseProtocol {
  private let defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol
  private let dBCategoriesService: DBCategoriesServiceProtocol

  public init(
    defaultCategoriesDataService: DefaultCategoriesDataServiceProtocol,
    dBCategoriesService: DBCategoriesServiceProtocol
  ) {
    self.defaultCategoriesDataService = defaultCategoriesDataService
    self.dBCategoriesService = dBCategoriesService
  }

  public func execute() async {
    let defaultCategories = defaultCategoriesDataService.takeDefaultCategories()
    let persistenceDefaultCategories = defaultCategories.map {
      ReminderPersistenceContracts.DefaultCategory(
        defaultKey: $0.defaultKey,
        title: $0.title,
        order: $0.order,
        isUserCreated: $0.isUserCreated,
        categoryRepeat: $0.categoryRepeat.rawValue,
        categoryGroup: $0.categoryGroup.rawValue
      )
    }

    try? await dBCategoriesService.addOrUpdate(defaultCategories: persistenceDefaultCategories)
  }
}
