//
//  CategoryEventEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

enum CategoryEventEntity {
  enum EditEventError: Error {
    case noEventToEdit
  }
  
  struct Event: Identifiable {
    let id: ObjectId
    let title: String
    let date: String
    let comment: String?
  }
}
