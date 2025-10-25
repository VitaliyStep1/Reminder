//
//  AppConfiguration.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation

public protocol AppConfigurationProtocol: Sendable {
  var isWithSplashScreen: Bool { get }
  var defaultDefaultRemindTime: (hour: Int, minute: Int, second: Int) { get }
  
  static var previewAppConfiguration: AppConfigurationProtocol { get }
}

public final class AppConfiguration: ObservableObject, @preconcurrency AppConfigurationProtocol {
  public let isWithSplashScreen = true
  public let defaultDefaultRemindTime = (hour: 10, minute: 0, second: 0)
  
  public init() { }
  
  @MainActor
  public static let previewAppConfiguration: AppConfigurationProtocol = AppConfiguration()
}
