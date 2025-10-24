//
//  UserDefaultsServiceProtocol.swift
//  ReminderUserDefaultsStorage
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation

public protocol UserDefaultsServiceProtocol {
  var defaultRemindTimeDate: Date? { get set }
}
