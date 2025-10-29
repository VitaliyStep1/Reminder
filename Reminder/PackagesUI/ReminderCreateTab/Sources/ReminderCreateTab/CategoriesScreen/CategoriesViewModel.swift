//
//  CategoriesViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import Combine
import ReminderDomainContracts
import ReminderNavigationContracts

@MainActor
public class CategoriesViewModel: ObservableObject {
  let fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol
  
  @Published var categoryEntities: [CategoriesCategoryEntity] = []
  @Published var navigationTitle: String = "Categories"
  let router: any CreateTabRouterProtocol
  private var cancellables: Set<AnyCancellable> = []

  public init(fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol, router: any CreateTabRouterProtocol) {
    self.fetchAllCategoriesUseCase = fetchAllCategoriesUseCase
    self.router = router

    router.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.objectWillChange.send()
      }
      .store(in: &cancellables)
  }
  
  func taskWasCalled() {
    
    loadCategories()
  }
  
  func categoryButtonClicked(_ categoryEntity: CategoriesCategoryEntity) {
    router.pushScreen(.category(categoryEntity.id))
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

  var routerPath: [Route] {
    get { router.path }
    set { router.path = newValue }
  }
}
