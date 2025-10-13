//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderNavigation
import ReminderDependencies

@main
struct ReminderApp: App {
  private let viewFactory: any ViewFactoryProtocol
  
  init() {
    let di = DIService()
    guard let viewFactory = di.resolver.resolve(ViewFactoryProtocol.self) else {
      fatalError("Failed to resolve ViewFactoryProtocol.")
    }
    self.viewFactory = viewFactory
  }
  
  var body: some Scene {
    WindowGroup {
      Group {
        viewFactory.make(.start)
          .environment(\.viewFactory, viewFactory)
      }
    }
  }
}


