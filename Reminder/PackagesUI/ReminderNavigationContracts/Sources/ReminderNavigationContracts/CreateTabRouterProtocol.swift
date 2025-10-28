//
//  RouterProtocol.swift
//  ReminderNavigationContracts
//
//  Created by Vitaliy Stepanenko on 28.10.2025.
//

import SwiftUI
import Combine

public protocol CreateTabRouterProtocol: ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher {
  var path: NavigationPath { get   set }
  
  func pushScreen(_: Route)
  func resetToScreen(_: Route)
  func popScreen()
}
