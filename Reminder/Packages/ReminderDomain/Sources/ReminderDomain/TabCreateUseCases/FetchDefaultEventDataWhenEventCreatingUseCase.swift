//
//  FetchDefaultEventDataWhenEventCreatingUseCase.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 25.10.2025.
//

import Foundation
import ReminderDomainContracts

public struct FetchDefaultEventDataWhenEventCreatingUseCase: FetchDefaultEventDataWhenEventCreatingUseCaseProtocol {
  
  private let defaultRemindTimeService: DefaultRemindTimeServiceProtocol
  
  public init(defaultRemindTimeService: DefaultRemindTimeServiceProtocol) {
    self.defaultRemindTimeService = defaultRemindTimeService
  }
  
  public func execute() -> (
    eventTitle: String,
    eventDate: Date,
    eventComment: String,
    eventRemindRepeat: RemindRepeatEnum,
    defaultRemindTimeDate: Date,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  ) {
    let eventTitle = ""
    let eventDate = Date()
    let eventComment = ""
    let eventRemindRepeat = RemindRepeatEnum.everyYear
    let defaultRemindTimeDate = defaultRemindTimeService.takeDefaultRemindTimeDate()
    let remindTimeDate1 = defaultRemindTimeDate
    let remindTimeDate2: Date? = nil
    let remindTimeDate3: Date? = nil

    return (
      eventTitle: eventTitle,
      eventDate: eventDate,
      eventComment: eventComment,
      eventRemindRepeat: eventRemindRepeat,
      defaultRemindTimeDate: defaultRemindTimeDate,
      remindTimeDate1: remindTimeDate1,
      remindTimeDate2: remindTimeDate2,
      remindTimeDate3: remindTimeDate3
    )
  }
}
