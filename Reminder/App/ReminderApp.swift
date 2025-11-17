//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDependencies
import ReminderNavigationContracts

@main
struct ReminderApp: App {
  private let startCoordinator: any StartCoordinatorProtocol

  init() {
    let di = DIService()
    let startCoordinator = di.resolver.startCoordinatorProtocol
    self.startCoordinator = startCoordinator
  }

  var body: some Scene {
    WindowGroup {
      startCoordinator.start()
    }
  }
}


