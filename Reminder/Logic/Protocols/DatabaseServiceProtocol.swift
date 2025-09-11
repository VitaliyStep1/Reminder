//
//  DatabaseServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

protocol DatabaseServiceProtocol {
  func addOrUpdate(defaultCategories: [DefaultCategory]) async throws
  func fetchAllCategories() async throws -> [Category]
}
