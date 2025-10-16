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
  let fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol
  
  @Published var categoryEntities: [CategoriesCategoryEntity] = []
  @Published var navigationTitle: String = "Categories"
  @Published var path: [CategoriesCategoryEntity] = []
  
  public init(fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol) {
    self.fetchAllCategoriesUseCase = fetchAllCategoriesUseCase
  }
  
  func taskWasCalled() {
    
    loadCategories()
  }
  
  func categoryButtonClicked(_ categoryEntity: CategoriesCategoryEntity) {
    path.append(categoryEntity)
  }
  
  func loadCategories() {
    Task {
      let allCategories = (try? await fetchAllCategoriesUseCase.execute()) ?? []
      let categoryEntities = allCategories.map(CategoriesCategoryEntity.init(category:))
      await MainActor.run {
        self.categoryEntities = categoryEntities
      }
    }
  }
}
