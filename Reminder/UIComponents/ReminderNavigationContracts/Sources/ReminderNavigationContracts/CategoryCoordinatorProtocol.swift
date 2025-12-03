//
//  CategoryCoordinatorProtocol.swift
//  ReminderNavigationContracts
//
//  Created by Vitaliy Stepanenko on 04.12.2025.
//

import SwiftUI
import ReminderDomainContracts

public typealias CategoryScreenBuilder = (_ categoryId: Identifier) -> AnyView

public protocol CategoryCoordinatorProtocol: AnyObject {
  func start(categoryId: Identifier) -> AnyView
}
