//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDependencies
import ReminderNavigationContracts
import ReminderStart
import ReminderDesignSystem
import ReminderAppDI

@main
struct ReminderApp: App {
  private let di: AppDI = AppDI.shared
  
  init() {
    DesignSystemFonts.registerFonts()
  }

  var body: some Scene {
    WindowGroup {
      di.makeRootView()
    }
  }
}


