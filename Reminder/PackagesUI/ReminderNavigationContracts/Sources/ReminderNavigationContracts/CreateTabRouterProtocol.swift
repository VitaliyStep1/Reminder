//
//  RouterProtocol.swift
//  ReminderNavigationContracts
//
//  Created by Vitaliy Stepanenko on 28.10.2025.
//

import SwiftUI
import Combine
import ReminderDomainContracts

public protocol CreateTabRouterProtocol: ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher {
  var path: [Route] { get set }

  func pushScreen(_: Route)
  func resetToScreen(_: Route)
  func popScreen()
  @MainActor
  func categoryEventWasUpdated(newCategoryId: Identifier?)
}
