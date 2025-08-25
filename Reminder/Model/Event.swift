//
//  Event.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

import Foundation

struct Event: Identifiable {
  let id: Int
  let title: String
  let date: Date
  let category: Category
}
