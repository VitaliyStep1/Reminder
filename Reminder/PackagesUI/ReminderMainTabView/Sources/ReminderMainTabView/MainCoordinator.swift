//
//  MainCoordinator.swift
//  ReminderMainTabView
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderResolver

@MainActor
public final class MainCoordinator: MainCoordinatorProtocol {
  private let resolver: Resolver
  private let closestCoordinator: any ClosestCoordinatorProtocol
  private let createCoordinator: any CreateCoordinatorProtocol
  private let settingsCoordinator: any SettingsCoordinatorProtocol

  public init(
    resolver: Resolver,
    closestCoordinator: any ClosestCoordinatorProtocol,
    createCoordinator: any CreateCoordinatorProtocol,
    settingsCoordinator: any SettingsCoordinatorProtocol
  ) {
    self.resolver = resolver
    self.closestCoordinator = closestCoordinator
    self.createCoordinator = createCoordinator
    self.settingsCoordinator = settingsCoordinator
  }

  public func start() -> AnyView {
    let view = MainTabView(
      closestCoordinator: closestCoordinator,
      createCoordinator: createCoordinator,
      settingsCoordinator: settingsCoordinator
    )
    .environmentObject(resolver.mainTabViewSelectionState)

    return AnyView(view)
  }
}
