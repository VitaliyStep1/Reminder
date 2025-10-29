//
//  EventEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

import ReminderDomainContracts

enum EventEntity {
  enum CreateEventError: Error {
    case titleShouldBeNotEmpty
  }
  
  enum RepeatRepresentationEnum {
    case picker(values: [RemindRepeatEnum], titles: [RemindRepeatEnum: String])
    case text(text: String)
  }
}
