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
import ReminderMainTabViewContracts

@MainActor
public final class MainCoordinator: CoordinatorProtocol {
  private let closestCoordinator: any CoordinatorProtocol
  private let createCoordinator: any CreateCoordinatorProtocol
  private let settingsCoordinator: any CoordinatorProtocol
  
  let mainTabViewSelectionState: MainTabViewSelectionState

  public init(
    mainTabViewSelectionState: MainTabViewSelectionState,
    closestCoordinator: any CoordinatorProtocol,
    createCoordinator: any CreateCoordinatorProtocol,
    settingsCoordinator: any CoordinatorProtocol
  ) {
    self.mainTabViewSelectionState = mainTabViewSelectionState
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
    .environmentObject(mainTabViewSelectionState)

    return AnyView(view)
  }
}
