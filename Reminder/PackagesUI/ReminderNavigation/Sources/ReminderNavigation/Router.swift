//
//  Router.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderNavigationContracts

public final class Router: CreateTabRouterProtocol, ObservableObject {
  @Published public var path = NavigationPath()
  
  public init() { }
  
  public func pushScreen(_ route: Route) {
    path.append(route)
  }
  
  public func resetToScreen(_ route: Route) {
    path = NavigationPath()
    path.append(route)
  }
  
  public func popScreen() {
    guard !path.isEmpty else {
      return
    }
    path.removeLast()
  }
}
