//
//  CreateFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderCreate

@MainActor
struct CreateFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(CreateCoordinator.self) { resolver in
      CreateCoordinator(resolver: resolver)
    }
    .inObjectScope(.container)
  }
}
