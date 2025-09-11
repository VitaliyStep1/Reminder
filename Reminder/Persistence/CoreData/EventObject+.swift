//
//  EventObject+.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

import Foundation


extension EventObject {
  func takeEvent() -> Event {
    Event(
      title: self.title ?? "",
      date: self.date ?? Date(),
      comment: self.comment ?? "",
      categoryId: self.category?.objectID
    )
  }
}
