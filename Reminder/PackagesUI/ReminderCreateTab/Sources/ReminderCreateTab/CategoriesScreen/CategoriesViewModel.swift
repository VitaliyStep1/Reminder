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
  
  @Published var screenStateEnum: CategoriesEntity.ScreenStateEnum
  @Published var navigationTitle: String = "Categories"
  let router: any CreateTabRouterProtocol
  private var cancellables: Set<AnyCancellable> = []
  
  private let noCategoriesText = "No categories was found"

  public init(fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol, router: any CreateTabRouterProtocol) {
    self.fetchAllCategoriesUseCase = fetchAllCategoriesUseCase
    self.router = router
    
    screenStateEnum = .empty(title: noCategoriesText)

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
  
  func categoryButtonClicked(_ category: CategoriesEntity.Category) {
    router.pushScreen(.category(category.id))
  }
  
  func loadCategories() {
    Task {
      let allCategories = (try? await fetchAllCategoriesUseCase.execute()) ?? []
      await MainActor.run {
        let categories = allCategories.map {
          let eventsAmountText = self.takeEventsAmountText(eventsAmount: $0.eventsAmount)
          return CategoriesEntity.Category(id: $0.id, title: $0.title, eventsAmountText: eventsAmountText)
        }
        
        if categories.isEmpty {
          self.screenStateEnum = .empty(title: self.noCategoriesText)
        } else {
          self.screenStateEnum = .withCategories(categories: categories)
        }
      }
    }
  }
  
  private func takeEventsAmountText(eventsAmount: Int) -> String {
    let title = eventsAmount == 1 ? "Event" : "Events"
    return "\(eventsAmount) \(title)"
  }

  var routerPath: [Route] {
    get { router.path }
    set { router.path = newValue }
  }
}
