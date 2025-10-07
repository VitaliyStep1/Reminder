//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

@main
struct ReminderApp: App {
  private let viewFactory: ViewFactory
  
  init() {
    let di = DIService()
    viewFactory = di.resolver.resolve(ViewFactory.self)!
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


