//
//  DefaultCategoriesDataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import ReminderPersistence

protocol DefaultCategoriesDataServiceProtocol {
  func takeDefaultCategories() -> [DefaultCategory]
}
