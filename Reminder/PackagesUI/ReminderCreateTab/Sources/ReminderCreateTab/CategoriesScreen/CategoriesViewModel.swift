//
//  CategoriesViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDomainContracts

@MainActor
public class CategoriesViewModel: ObservableObject {
  let dataService: DataServiceProtocol
  
  @Published var categoryEntities: [CategoriesCategoryEntity] = []
  @Published var navigationTitle: String = "Categories"
  @Published var path: [CategoriesCategoryEntity] = []
  
  public init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }
  
  func taskWasCalled() {
    
    loadCategories()
  }
  
  func categoryButtonClicked(_ categoryEntity: CategoriesCategoryEntity) {
    path.append(categoryEntity)
  }
  
  func loadCategories() {
    Task {
      let allCategories: [ReminderDomainContracts.Category]
      do {
        allCategories = try await dataService.takeAllCategories()
      } catch {
        allCategories = []
      }
      let categoryEntities = allCategories.map(CategoriesCategoryEntity.init(category:))
      await MainActor.run {
        self.categoryEntities = categoryEntities
      }
    }
  }
}
