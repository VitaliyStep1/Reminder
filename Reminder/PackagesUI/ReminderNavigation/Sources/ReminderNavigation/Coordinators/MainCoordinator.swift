//
//  MainCoordinator.swift
//  ReminderNavigation
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderMainTabView
import ReminderResolver

@MainActor
public final class MainCoordinator: MainCoordinatorProtocol {
  private let resolver: Resolver
  private let closestCoordinator: ClosestCoordinator
  private let createCoordinator: CreateCoordinator
  private let settingsCoordinator: SettingsCoordinator

  public init(
    resolver: Resolver,
    closestCoordinator: ClosestCoordinator,
    createCoordinator: CreateCoordinator,
    settingsCoordinator: SettingsCoordinator
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
