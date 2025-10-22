//
//  CategoryEventEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

import ReminderDomainContracts

enum CategoryEventEntity {
  enum CreateEventError: Error {
    case titleShouldBeNotEmpty
  }
  
  enum RepeatRepresentationEnum {
    case picker(values: [RemindRepeatEnum], titles: [RemindRepeatEnum: String])
    case text(text: String)
  }
}
