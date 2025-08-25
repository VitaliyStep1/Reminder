//
//  CategoriesViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

class CategoriesViewModel: ObservableObject {
  let dataService: DataService = DataService()
  
  @Published var categoryEntities: [CategoriesCategoryEntity] = []
  @Published var navigationTitle: String = "Categories"
  
  init() {
    loadCategories()
  }
  
  func loadCategories() {
    let allCategories = dataService.takeAllCategories()
    categoryEntities = takeCategoryEntities(categories: allCategories)
  }
  
  func takeCategoryEntities(categories: [Category]) -> [CategoriesCategoryEntity] {
    let mockCategoryEntities: [CategoriesCategoryEntity] = [
      .init(id: 1, title: "Category 1", eventsAmount: "5"),
      .init(id: 2, title: "Category 2", eventsAmount: "7"),
      .init(id: 3, title: "Category 3", eventsAmount: ""),
      .init(id: 4, title: "Category 4", eventsAmount: "1"),
      .init(id: 5, title: "Category 5", eventsAmount: "123"),
    ]
    
    return mockCategoryEntities
  }
}
