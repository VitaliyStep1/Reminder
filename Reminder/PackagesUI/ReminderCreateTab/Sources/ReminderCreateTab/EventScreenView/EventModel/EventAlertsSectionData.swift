//
//  EventAlertsSectionData.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import Foundation
import ReminderDomainContracts

@MainActor
class EventAlertsSectionData: ObservableObject {
  
  @Published var repeatRepresentationEnum: EventEntity.RepeatRepresentationEnum
  
  @Published var isRemindTime2ViewVisible: Bool
  @Published var isRemindTime3ViewVisible: Bool
  @Published var isAddRemindTimeButtonVisible: Bool
  
  @Published public var defaultRemindTimeDate: Date
  
  @Published var remindRepeat: RemindRepeatEnum
  @Published var remindTimeDate1: Date
  @Published var remindTimeDate2: Date? {
    didSet { updateRemindTimeVisibility() }
  }
  @Published var remindTimeDate3: Date? {
    didSet { updateRemindTimeVisibility() }
  }
  
  public init(
    repeatRepresentationEnum: EventEntity.RepeatRepresentationEnum,
    remindRepeat: RemindRepeatEnum,
    isRemindTime2ViewVisible: Bool,
    isRemindTime3ViewVisible: Bool,
    isAddRemindTimeButtonVisible: Bool,
    defaultRemindTimeDate: Date,
    remindTimeDate1: Date,
    remindTimeDate2: Date?,
    remindTimeDate3: Date?
  ) {
    self.repeatRepresentationEnum = repeatRepresentationEnum
    self.remindRepeat = remindRepeat
    self.isRemindTime2ViewVisible = isRemindTime2ViewVisible
    self.isRemindTime3ViewVisible = isRemindTime3ViewVisible
    self.isAddRemindTimeButtonVisible = isAddRemindTimeButtonVisible
    self.defaultRemindTimeDate = defaultRemindTimeDate
    self.remindTimeDate1 = remindTimeDate1
    self.remindTimeDate2 = remindTimeDate2
    self.remindTimeDate3 = remindTimeDate3
    
    updateRemindTimeVisibility()
  }
  
  private func updateRemindTimeVisibility() {
    isRemindTime2ViewVisible = remindTimeDate2 != nil
    isRemindTime3ViewVisible = remindTimeDate3 != nil
    isAddRemindTimeButtonVisible = !isRemindTime3ViewVisible
  }
}
