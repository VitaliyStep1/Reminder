//
//  AppConfiguration.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation

class AppConfiguration: ObservableObject {
  let isWithSplashScreen = true
  
  @MainActor
  static let previewAppConfiguration = AppConfiguration()
}
