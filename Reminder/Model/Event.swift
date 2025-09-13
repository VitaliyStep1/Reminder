//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation

struct Event {
  let id: ObjectId
  let title: String
  let date: Date
  let comment: String
  let categoryId: ObjectId?
}
