//
//  FetchDefaultEventDataWhenEventCreatingUseCaseProtocol.swift
//  ReminderDomainContracts
//
//  Created by Vitaliy Stepanenko on 25.10.2025.
//

import Foundation

public protocol FetchDefaultEventDataWhenEventCreatingUseCaseProtocol: Sendable {
  func execute() -> (
    eventTitle: String,
    eventDate: Date,
    eventComment: String,
    eventRemindRepeat: RemindRepeatEnum,
    defaultRemindTimeDate: Date,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  )
}
