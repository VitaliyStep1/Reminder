//
//  SettingsViewModel.swift
//  ReminderSettingsTab
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation
import ReminderDomainContracts

@MainActor
public final class SettingsViewModel: ObservableObject {
  let takeDefaultRemindTimeDateUseCase: TakeDefaultRemindTimeDateUseCaseProtocol
  let updateDefaultRemindTimeDateUseCase: UpdateDefaultRemindTimeDateUseCaseProtocol
  
  let takeSettingsLanguageUseCase: TakeSettingsLanguageUseCaseProtocol
  let updateSettingsLanguageUseCase: UpdateSettingsLanguageUseCaseProtocol
  
  @Published public var defaultRemindTimeDate: Date {
    didSet {
      guard defaultRemindTimeDate != oldValue else {
        return
      }
      
      updateDefaultRemindTimeDateUseCase.execute(date: defaultRemindTimeDate)
    }
  }
  
  let languageOptionViewStore: SettingsLanguageOptionViewStore

  public init(takeDefaultRemindTimeDateUseCase: TakeDefaultRemindTimeDateUseCaseProtocol, updateDefaultRemindTimeDateUseCase: UpdateDefaultRemindTimeDateUseCaseProtocol, takeSettingsLanguageUseCase: TakeSettingsLanguageUseCaseProtocol, updateSettingsLanguageUseCase: UpdateSettingsLanguageUseCaseProtocol) {
    self.takeDefaultRemindTimeDateUseCase = takeDefaultRemindTimeDateUseCase
    self.updateDefaultRemindTimeDateUseCase = updateDefaultRemindTimeDateUseCase
    self.takeSettingsLanguageUseCase = takeSettingsLanguageUseCase
    self.updateSettingsLanguageUseCase = updateSettingsLanguageUseCase
    
    languageOptionViewStore = SettingsLanguageOptionViewStore {
      let languageEnum = $0.languageEnum
      updateSettingsLanguageUseCase.execute(language: languageEnum)
    }
    
    self.defaultRemindTimeDate = takeDefaultRemindTimeDateUseCase.execute()
    
    let settingsLanguage = takeSettingsLanguageUseCase.execute()
    self.languageOptionViewStore.setSettingsLanguage(settingsLanguage)
  }
}
