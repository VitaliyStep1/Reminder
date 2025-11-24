//
//  Router.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDomainContracts

public final class CreateRouter: CreateRouterProtocol, ObservableObject {
  @Published public var path: [CreateRoute] = []

  public init() { }

  public func pushScreen(_ route: CreateRoute) {
    var updatedPath = path
    updatedPath.append(route)
    path = updatedPath
  }

  public func resetToScreen(_ route: CreateRoute) {
    path = [route]
  }

  public func popScreen() {
    guard !path.isEmpty else {
      return
    }
    var updatedPath = path
    updatedPath.removeLast()
    path = updatedPath
  }

  @MainActor
  public func categoryEventWasUpdated(newCategoryId: Identifier?) {
    guard let newCategoryId else {
      return
    }

    guard let categoryIndex = path.lastIndex(where: { route in
      if case .category = route {
        return true
      }
      return false
    }) else {
      return
    }

    var updatedPath = path
    updatedPath[categoryIndex] = .category(newCategoryId)
    path = updatedPath
  }
}
