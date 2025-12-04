//
//  ClosestFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import SwiftUI
import Swinject
import ReminderClosest
import ReminderMainTabViewContracts

@MainActor
struct ClosestFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(ClosestViewModel.self) { r in
      let mainTabViewSelectionState = r.resolve(MainTabViewSelectionState.self)!
      return ClosestViewModel(mainTabViewSelectionState: mainTabViewSelectionState)
    }
    
    container.register(ClosestCoordinator.self) { r in
      let closestScreenBuilder = r.resolve(ClosestScreenBuilder.self)!
      return ClosestCoordinator(closestScreenBuilder: closestScreenBuilder)
    }
    .inObjectScope(.container)
    
    container.register(ClosestScreenBuilder.self) { r in
      {
        let closestViewModel = r.resolve(ClosestViewModel.self)!
        return ClosestScreenView(viewModel: closestViewModel)
      }
    }
  }
}
