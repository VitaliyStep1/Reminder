//
//  RouterProtocol.swift
//  ReminderNavigationContracts
//
//  Created by Vitaliy Stepanenko on 28.10.2025.
//

import SwiftUI
import Combine
import ReminderDomainContracts

public protocol CreateRouterProtocol: ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher {
  var path: [CreateRoute] { get set }

  func pushScreen(_: CreateRoute)
  func resetToScreen(_: CreateRoute)
  func popScreen()
  @MainActor
  func categoryEventWasUpdated(newCategoryId: Identifier?)
}
