//
//  UpdateSettingsLanguageUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 21.11.2025.
//

import Foundation

public protocol UpdateSettingsLanguageUseCaseProtocol {
  func execute(language: LanguageEnum)
}
