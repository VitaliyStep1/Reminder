//
//  DefaultCategoriesDataServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

public protocol DefaultCategoriesDataServiceProtocol: Sendable {
  func takeDefaultCategories() -> [DefaultCategory]
}
