//
//  TakeDefaultRemindTimeDateUseCase.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import Foundation
import ReminderDomainContracts
import ReminderConfigurations
import ReminderUserDefaultsStorage

public class TakeDefaultRemindTimeDateUseCase: TakeDefaultRemindTimeDateUseCaseProtocol {
  private let defaultRemindTimeService: DefaultRemindTimeServiceProtocol
  
  public init(defaultRemindTimeService: DefaultRemindTimeServiceProtocol) {
    self.defaultRemindTimeService = defaultRemindTimeService
  }

  public func execute() -> Date {
    let defaultRemindTimeDate = defaultRemindTimeService.takeDefaultRemindTimeDate()
    return defaultRemindTimeDate
  }
}
