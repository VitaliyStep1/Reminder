//
//  LanguageServiceProtocol.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 21.11.2025.
//

import Foundation

public protocol LanguageServiceProtocol: AnyObject {
  var locale: Locale { get }
  func updateLanguage(_ languageEnum: LanguageEnum)
}
