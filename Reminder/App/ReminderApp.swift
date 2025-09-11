//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

@main
struct ReminderApp: App {
  @StateObject var appConfiguration = AppConfiguration()
  @StateObject var appDependencies = AppDependencies()
  
  var body: some Scene {
    WindowGroup {
      StartScreenView()
    }
    .environmentObject(appConfiguration)
    .environmentObject(appDependencies)
  }
}
