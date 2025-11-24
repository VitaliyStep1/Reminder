//
//  CreateCoordinatorProtocol.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 16.11.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDomainContracts

public protocol CreateCoordinatorProtocol: CoordinatorProtocol {
  var router: any CreateRouterProtocol { get }
  func destination(for route: CreateRoute) -> AnyView
  func categoriesScreenCategoryWasClicked(categoryId: Identifier)
}
