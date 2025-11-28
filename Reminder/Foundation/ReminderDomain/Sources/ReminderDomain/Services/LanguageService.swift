//
//  LanguageService.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 21.11.2025.
//

import Foundation
import ReminderDomainContracts

//@MainActor
@Observable
public class LanguageService: LanguageServiceProtocol {
  @ObservationIgnored let takeSettingsLanguageUseCase: TakeSettingsLanguageUseCaseProtocol
  
  private var languageEnum: LanguageEnum
  
  public var locale: Locale {
    let languageCode = takeLanguageCode()
    let locale = Locale(identifier: languageCode) ?? Locale(identifier: "en")
    return locale
  }
  
  public init(takeSettingsLanguageUseCase: TakeSettingsLanguageUseCaseProtocol) {
    self.takeSettingsLanguageUseCase = takeSettingsLanguageUseCase
    
    languageEnum = takeSettingsLanguageUseCase.execute()
  }
  
  private func takeLanguageCode() -> String {
    switch languageEnum {
    case .ukr:
      return "uk"
    case .eng:
      return "en"
    }
  }
  
  public func updateLanguage(_ languageEnum: LanguageEnum) {
    self.languageEnum = languageEnum
  }
}
