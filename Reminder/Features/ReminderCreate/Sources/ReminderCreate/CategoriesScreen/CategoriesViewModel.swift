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
import ReminderDomain

@MainActor
public class CategoriesViewModel: ObservableObject {
  
  let fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol
  
  @Published var screenStateEnum: CategoriesEntity.ScreenStateEnum
  var navigationTitle: String = String(localized: Localize.categoriesNavigationTitle)
  
  public weak var coordinator: (any CreateCoordinatorProtocol)? {
    didSet {
      subscribeToRouterChanges()
    }
  }
  private var cancellables: Set<AnyCancellable> = []
  
  private let noCategoriesText = Localize.noCategoriesText

  public init(fetchAllCategoriesUseCase: FetchAllCategoriesUseCaseProtocol,
              coordinator: (any CreateCoordinatorProtocol)? = nil) {
    self.fetchAllCategoriesUseCase = fetchAllCategoriesUseCase
    self.coordinator = coordinator
    
    screenStateEnum = .empty(title: noCategoriesText)
    
    subscribeToRouterChanges()
  }
  
  func taskWasCalled() {
    loadCategories()
  }
  
  func categoryRowWasClicked(_ category: CategoriesEntity.Category) {
    coordinator?.categoriesScreenCategoryWasClicked(categoryId: category.id)
  }
  
  func loadCategories() {
    Task {
      let allCategories = (try? await fetchAllCategoriesUseCase.execute()) ?? []
      await MainActor.run {
        let categories = allCategories.map {
          return CategoriesEntity.Category(id: $0.id, title: $0.title, eventsAmount: $0.eventsAmount)
        }
        
        if categories.isEmpty {
          self.screenStateEnum = .empty(title: self.noCategoriesText)
        } else {
          self.screenStateEnum = .withCategories(categories: categories)
        }
      }
    }
  }
  
  func takeEventsAmountText(eventsAmount: Int, locale: Locale) -> String {
    let title = eventsAmount == 1 ? String(localized: Localize.eventSingular.localed(locale)) : String(localized: Localize.eventsPlural.localed(locale))
    return "\(eventsAmount) \(title)"
  }
  
  func takeLocalizedCategoryTitle(categoryTitle: String, locale: Locale) -> String {
    CategoryLocalizationManager.shared.localize(categoryTitle: categoryTitle, locale: locale)
  }
  
  var routerPath: [CreateRoute] {
    get { coordinator?.router.path ?? [] }
    set { coordinator?.router.path = newValue }
  }

  private func subscribeToRouterChanges() {
    cancellables.removeAll()

    coordinator?.router.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.objectWillChange.send()
      }
      .store(in: &cancellables)
  }
}
