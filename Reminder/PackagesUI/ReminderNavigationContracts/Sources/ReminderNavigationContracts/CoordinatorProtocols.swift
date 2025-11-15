//
//  CoordinatorProtocols.swift
//  ReminderNavigationContracts
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI

@MainActor
public protocol MainCoordinatorProtocol: AnyObject {
  func start() -> AnyView
}

@MainActor
public protocol ClosestCoordinatorProtocol: AnyObject {
  func start() -> AnyView
}

@MainActor
public protocol CreateCoordinatorProtocol: AnyObject {
  func start() -> AnyView
  func destination(for route: Route) -> AnyView
}

@MainActor
public protocol SettingsCoordinatorProtocol: AnyObject {
  func start() -> AnyView
}
