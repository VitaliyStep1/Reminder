//
//  DataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

protocol DataServiceProtocol {
  func takeAllCategories() -> [Category]
  func takeAllEvents() -> [Event]
}
