//
//  DBCategoriesServiceProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 24.08.2025.
//

public protocol DBCategoriesServiceProtocol {
  func addOrUpdate(defaultCategories: [DefaultCategory]) async throws
  func fetchAllCategories() async throws -> [Category]
  func takeFirstCategoryObjectId() async throws -> ObjectId?
  func fetchCategory(categoryId: ObjectId) async throws -> Category?
}
