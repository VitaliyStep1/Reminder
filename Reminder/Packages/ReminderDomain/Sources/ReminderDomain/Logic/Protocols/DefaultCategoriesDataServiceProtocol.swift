//
//  DefaultCategoriesDataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import ReminderPersistence

public protocol DefaultCategoriesDataServiceProtocol {
  func takeDefaultCategories() -> [DefaultCategory]
}
