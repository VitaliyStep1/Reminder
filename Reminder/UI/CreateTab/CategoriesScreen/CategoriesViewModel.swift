//
//  CategoriesViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

class CategoriesViewModel: ObservableObject {
  var dataService: DataServiceProtocol?
  
  @Published var categoryEntities: [CategoriesCategoryEntity] = []
  @Published var navigationTitle: String = "Categories"
  @Published var path: [CategoriesCategoryEntity] = []
  
  func setupDataService(dataService: DataServiceProtocol) {
    self.dataService = dataService
    
    loadCategories()
  }
  
  func categoryButtonClicked(_ categoryEntity: CategoriesCategoryEntity) {
    path.append(categoryEntity)
  }
  
  func loadCategories() {
    Task {
      let allCategories = await dataService?.takeAllCategories() ?? []
      let categoryEntities = allCategories.map(CategoriesCategoryEntity.init(category:))
      await MainActor.run {
        self.categoryEntities = categoryEntities
      }
    }
  }
}
