//
//  RemindRepeatEnum.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 17.10.2025.
//

public enum RemindRepeatEnum: Int, CaseIterable, Sendable {
  case everyYear = 1
  case everyMonth = 2
  case everyDay = 3
  case notRepeat = 4
  
  public init(fromRawValue: Int) {
    self = Self.init(rawValue: fromRawValue) ?? .everyYear
  }
}
