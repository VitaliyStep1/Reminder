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
  
  @Published public var remindTimeDate: Date {
    didSet {
      guard remindTimeDate != oldValue else {
        return
      }
      
      updateDefaultRemindTimeDateUseCase.execute(date: remindTimeDate)
    }
  }

  public init(takeDefaultRemindTimeDateUseCase: TakeDefaultRemindTimeDateUseCaseProtocol, updateDefaultRemindTimeDateUseCase: UpdateDefaultRemindTimeDateUseCaseProtocol) {
    self.takeDefaultRemindTimeDateUseCase = takeDefaultRemindTimeDateUseCase
    self.updateDefaultRemindTimeDateUseCase = updateDefaultRemindTimeDateUseCase
    self.remindTimeDate = takeDefaultRemindTimeDateUseCase.execute()
  }
}
