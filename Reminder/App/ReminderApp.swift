//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import CoreData

@main
struct ReminderApp: App {
  @StateObject var appConfiguration = AppConfiguration()
  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
  
  var body: some Scene {
    WindowGroup {
      Group {
        if let appDependencies = appDependenciesLoader.instance {
          StartScreenView()
            .environmentObject(appConfiguration)
            .environmentObject(appDependencies)
        } else {
          // TODO: Splash screen should appear here!
          ProgressView("Loading…")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
      .task {
        await appDependenciesLoader.load()
      }
    }
  }
}


