//
//  UserDefaultsServiceProtocol.swift
//  ReminderUserDefaultsStorage
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation

public protocol UserDefaultsServiceProtocol: AnyObject, Sendable {
  var defaultRemindTimeDate: Date? { get set }
  var settingsLanguageId: String? { get set }
}
