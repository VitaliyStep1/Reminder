//
//  Router.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderNavigationContracts

@MainActor
final class Router: ObservableObject {
  @Published var path = NavigationPath()
  
  func pushScreen(_ route: Route) {
    path.append(route)
  }
  
  func resetToScreen(_ route: Route) {
    path = NavigationPath()
    path.append(route)
  }
  
  func popScreen() {
    guard !path.isEmpty else {
      return
    }
    path.removeLast()
  }
}
