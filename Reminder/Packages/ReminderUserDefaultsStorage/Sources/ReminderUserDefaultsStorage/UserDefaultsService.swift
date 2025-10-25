//
//  UserDefaultsService.swift
//  ReminderUserDefaultsStorage
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation

public class UserDefaultsService: UserDefaultsServiceProtocol {
  public init() {}
  
  private func object(_ key: UserDefaultsKeyEnum) -> Any? {
    let object = UserDefaults.standard.object(forKey: key.rawValue)
    return object
  }
  
  private func set(_ value: Any?, key: UserDefaultsKeyEnum) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
  }
  
  public var defaultRemindTimeDate: Date? {
    get { object(.defaultRemindTimeDate) as? Date }
    set { set(newValue, key: .defaultRemindTimeDate) }
  }
}
