//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDependencies
import ReminderNavigationContracts
import ReminderStartUI

@main
struct ReminderApp: App {
  private let startCoordinator: any CoordinatorProtocol

  init() {
    let di = DIService()
    let startCoordinator = StartCoordinator(resolver: di.resolver)
    self.startCoordinator = startCoordinator
  }

  var body: some Scene {
    WindowGroup {
      startCoordinator.start()
    }
  }
}


