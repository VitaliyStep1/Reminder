//
//  CategoryGroupEnum.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 21.10.2025.
//

public enum CategoryGroupEnum: Int, CaseIterable, Sendable {
  case birthdays = 1
  case subscriptions = 2
  case utilities = 3
  case aniversaries = 4
  case other = 5
  
  public init(fromRawValue: Int) {
    self = Self.init(rawValue: fromRawValue) ?? .birthdays
  }
}
