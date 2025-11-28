//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Combine
import Foundation
import ReminderNavigationContracts
import ReminderDomainContracts
import ReminderDomain

@MainActor
public class CategoryViewModel: ObservableObject {
  let fetchEventsUseCase: FetchEventsUseCaseProtocol
  let fetchCategoryUseCase: FetchCategoryUseCaseProtocol
  var categoryId: Identifier
  private var locale: Locale = .current
  
  @Published var screenStateEnum: CategoryEntity.ScreenStateEnum
  
  private var events: [CategoryEntity.Event] = [] {
    didSet {
      updateScreenState()
    }
  }
  @Published var navigationTitle: String = "" {
    didSet {
      headerTitle = navigationTitle
    }
  }
  @Published var isAlertVisible: Bool = false
  @Published var headerTitle: String = ""
  @Published var headerSubTitle: String = ""
  var router: any CreateRouterProtocol
  
  var alertInfo: ErrorAlertInfo = ErrorAlertInfo(message: "")

  var createEventViewTitle = ""
  var createEventViewDate = Date()
  var createEventViewComment = ""
  private let noEventsText = Localize.categoryNoEventsText
  
  private var cancellables: Set<AnyCancellable> = []
  
  public init(
    categoryId: Identifier,
    fetchEventsUseCase: FetchEventsUseCaseProtocol,
    fetchCategoryUseCase: FetchCategoryUseCaseProtocol, router: any CreateRouterProtocol
  ) {
    self.categoryId = categoryId
    self.fetchEventsUseCase = fetchEventsUseCase
    self.fetchCategoryUseCase = fetchCategoryUseCase
    self.router = router
    self.screenStateEnum = .empty(title: noEventsText.localed(locale))
    
    observeRouterUpdates()
  }
  
  func updateLocale(_ locale: Locale) {
    self.locale = locale
    updateScreenState()
  }

  func viewAppeared() {
    updateEventList()
    updateNavigationTitle()
  }
  
  func viewTaskCalled() {
    updateEventList()
    updateNavigationTitle()
  }
  
  func addButtonTapped() {
    showCreateEventView()
  }
  
  func eventTapped(eventId: Identifier) {
    showEditEventView(eventId: eventId)
  }
  
  func closeViewWasCalled() {
    router.popScreen()
  }
  
  private func showCreateEventView() {
    let eventScreenViewType = EventScreenViewType.create(categoryId: categoryId)
    router.pushScreen(.event(eventScreenViewType))
  }
  
  private func updateEventList() {
    Task {
      do {
        let events = try await fetchEventsUseCase.execute(categoryId: categoryId)
        let entityEvents: [CategoryEntity.Event] = events.map { event in
          let date = event.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits))
          return CategoryEntity.Event(id: event.id, title: event.title, date: date)
        }
        
        self.events = entityEvents
      } catch {
        showEventsWereNotFetchedAlert()
      }
    }
  }
  
  private func updateNavigationTitle() {
    Task {
      let category = try? await fetchCategoryUseCase.execute(categoryId: categoryId)
      let categoryTitle = category?.title ?? ""
      
      navigationTitle = CategoryLocalizationManager.shared.localize(categoryTitle: categoryTitle, locale: locale)
    }
  }
  
  private func showEditEventView(eventId: Identifier) {
    let eventScreenViewType = EventScreenViewType.edit(eventId: eventId)
    router.pushScreen(.event(eventScreenViewType))
  }

  private func showEventsWereNotFetchedAlert() {
    alertInfo = ErrorAlertInfo(message: String(localized: Localize.eventsNotFetchedAlert.localed(locale)))
    isAlertVisible = true
  }
  
  private func observeRouterUpdates() {
    router.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self else { return }
        self.handleRouterPathUpdate()
      }
      .store(in: &cancellables)
  }
  
  private func handleRouterPathUpdate() {
    guard let categoryRoute = router.path.last(where: { route in
      if case .category = route {
        return true
      }
      return false
    }) else {
      return
    }
    
    guard case let .category(newCategoryId) = categoryRoute else {
      return
    }
    
    guard newCategoryId != categoryId else {
      return
    }
    
    categoryId = newCategoryId
    updateEventList()
    updateNavigationTitle()
  }

  private func updateScreenState() {
    let eventsTitle = events.count == 1 ? String(localized: Localize.eventSingular.localed(locale)) : String(localized: Localize.eventsPlural.localed(locale))
    headerSubTitle = String(format: String(localized: Localize.addedEventsFormat.localed(locale)), events.count, eventsTitle)

    if events.isEmpty {
      screenStateEnum = .empty(title: noEventsText.localed(locale))
    } else {
      screenStateEnum = .withEvents(events: events)
    }
  }
}
