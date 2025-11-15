//
//  MainTabView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderMainTabViewContracts

public struct MainTabView: View {
  private let closestCoordinator: any ClosestCoordinatorProtocol
  private let createCoordinator: any CreateCoordinatorProtocol
  private let settingsCoordinator: any SettingsCoordinatorProtocol
  @EnvironmentObject var mainTabViewSelectionState: MainTabViewSelectionState

  public init(
    closestCoordinator: any ClosestCoordinatorProtocol,
    createCoordinator: any CreateCoordinatorProtocol,
    settingsCoordinator: any SettingsCoordinatorProtocol
  ) {
    self.closestCoordinator = closestCoordinator
    self.createCoordinator = createCoordinator
    self.settingsCoordinator = settingsCoordinator
  }

  public var body: some View {
    TabView(selection: $mainTabViewSelectionState.selection) {
      closestCoordinator.start()
        .tabItem {
          Image(systemName: "calendar.badge.clock")
          Text("Closest events")
        }
        .tag(MainTabViewSelectionEnum.closest)
      createCoordinator.start()
        .tabItem {
          Image(systemName: "plus.circle")
          Text("Create event")
        }
        .tag(MainTabViewSelectionEnum.create)
      settingsCoordinator.start()
        .tabItem {
          Image(systemName: "gearshape")
          Text("Settings")
        }
        .tag(MainTabViewSelectionEnum.settings)
    }
  }
}
