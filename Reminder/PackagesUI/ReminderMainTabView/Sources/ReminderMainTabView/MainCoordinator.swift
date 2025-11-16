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
import ReminderCreateTab

@MainActor
public final class MainCoordinator: CoordinatorProtocol {
  private let resolver: Resolver
  private let closestCoordinator: any CoordinatorProtocol
  private let createCoordinator: any CreateCoordinatorProtocol
  private let settingsCoordinator: any CoordinatorProtocol

  public init(
    resolver: Resolver,
    closestCoordinator: any CoordinatorProtocol,
    createCoordinator: any CreateCoordinatorProtocol,
    settingsCoordinator: any CoordinatorProtocol
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
