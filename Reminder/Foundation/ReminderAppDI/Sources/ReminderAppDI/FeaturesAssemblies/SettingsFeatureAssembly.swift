//
//  SettingsFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderSettings

@MainActor
struct SettingsFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SettingsCoordinator.self) { resolver in
      SettingsCoordinator(resolver: resolver)
    }
    .inObjectScope(.container)
  }
}
