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
  
  @Published public var defaultRemindTimeDate: Date {
    didSet {
      guard defaultRemindTimeDate != oldValue else {
        return
      }
      
      updateDefaultRemindTimeDateUseCase.execute(date: defaultRemindTimeDate)
    }
  }

  public init(takeDefaultRemindTimeDateUseCase: TakeDefaultRemindTimeDateUseCaseProtocol, updateDefaultRemindTimeDateUseCase: UpdateDefaultRemindTimeDateUseCaseProtocol) {
    self.takeDefaultRemindTimeDateUseCase = takeDefaultRemindTimeDateUseCase
    self.updateDefaultRemindTimeDateUseCase = updateDefaultRemindTimeDateUseCase
    self.defaultRemindTimeDate = takeDefaultRemindTimeDateUseCase.execute()
  }
}
