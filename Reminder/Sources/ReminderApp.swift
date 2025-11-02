//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDependencies

@main
struct ReminderApp: App {
  private let viewFactory: any ViewFactoryProtocol
  
  init() {
    let di = DIService()
    let viewFactory = di.resolver.viewFactoryProtocol
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


