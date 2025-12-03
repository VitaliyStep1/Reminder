//
//  ClosestFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderClosest
import ReminderMainTabViewContracts

@MainActor
struct ClosestFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(ClosestCoordinator.self) { resolver in
      let selectionState = resolver.resolve(MainTabViewSelectionState.self)!
      return ClosestCoordinator(mainTabViewSelectionState: selectionState)
    }
    .inObjectScope(.container)
  }
}
