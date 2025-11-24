//
//  DefaultRemindTimeServiceProtocol.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 26.10.2025.
//

import Foundation
import ReminderConfigurations
import ReminderUserDefaultsStorage

public protocol DefaultRemindTimeServiceProtocol: Sendable {
  init(appConfiguration: AppConfigurationProtocol, userDefaultsService: UserDefaultsServiceProtocol)
  
  func takeDefaultRemindTimeDate() -> Date
}
