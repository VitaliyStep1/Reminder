//
//  AppConfiguration.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation

protocol AppConfigurationProtocol {
  var isWithSplashScreen: Bool { get }
  
  static var previewAppConfiguration: AppConfigurationProtocol { get }
}

class AppConfiguration: ObservableObject, @preconcurrency AppConfigurationProtocol {
  let isWithSplashScreen = true
  
  @MainActor
  static let previewAppConfiguration: AppConfigurationProtocol = AppConfiguration()
}
