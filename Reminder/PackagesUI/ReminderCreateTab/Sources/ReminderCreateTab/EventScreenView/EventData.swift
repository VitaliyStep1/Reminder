//
//  EventData.swift
//  ReminderCreateTab
//
//  Created by AI on 07.11.2025.
//

import Foundation
import ReminderDomainContracts

@MainActor
public final class EventData: ObservableObject {
  public var onRemindTimeDatesChange: (() -> Void)?

  @Published public var title: String
  @Published public var date: Date
  @Published public var comment: String
  @Published public var remindRepeat: RemindRepeatEnum
  @Published public var remindTimeDate1: Date
  @Published public var remindTimeDate2: Date? { didSet { onRemindTimeDatesChange?() } }
  @Published public var remindTimeDate3: Date? { didSet { onRemindTimeDatesChange?() } }

  public init(
    title: String,
    date: Date,
    comment: String,
    remindRepeat: RemindRepeatEnum,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  ) {
    self.title = title
    self.date = date
    self.comment = comment
    self.remindRepeat = remindRepeat
    self.remindTimeDate1 = remindTimeDate1
    self.remindTimeDate2 = remindTimeDate2
    self.remindTimeDate3 = remindTimeDate3
  }
}

