//
//  UpdateSettingsLanguageUseCaseProtocol.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 21.11.2025.
//

import Foundation
import ReminderDomainContracts
import ReminderUserDefaultsStorage

public class UpdateSettingsLanguageUseCase: UpdateSettingsLanguageUseCaseProtocol {
  private let userDefaultsService: UserDefaultsServiceProtocol
  private let languageService: LanguageServiceProtocol
  
  public init(userDefaultsService: UserDefaultsServiceProtocol, languageService: LanguageServiceProtocol) {
    self.userDefaultsService = userDefaultsService
    self.languageService = languageService
  }
  
  public func execute(language: LanguageEnum) {
    userDefaultsService.settingsLanguageId = language.id
    changeLanguageInUI(language: language)
  }
  
  private func changeLanguageInUI(language: LanguageEnum) {
    languageService.updateLanguage(language)
    
    let languageCode: String
    switch language {
    case .eng:
      languageCode = "en"
    case .ukr:
      languageCode = "uk"
    }
    
    UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
  }
}
