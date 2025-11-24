//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import Combine
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public class CategoryViewModel: ObservableObject {
  let fetchEventsUseCase: FetchEventsUseCaseProtocol
  let fetchCategoryUseCase: FetchCategoryUseCaseProtocol
  var categoryId: Identifier
  
  @Published var screenStateEnum: CategoryEntity.ScreenStateEnum
  
  private var events: [CategoryEntity.Event] = [] {
    didSet {
      let eventsTitle = events.count == 1 ? TextEnum.eventSingular.localized : TextEnum.eventsPlural.localized
      headerSubTitle = String(format: TextEnum.addedEventsFormat.localized, events.count, eventsTitle)
      if events.isEmpty {
        screenStateEnum = .empty(title: noEventsText)
      } else {
        screenStateEnum = .withEvents(events: events)
      }
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
  private let noEventsText = TextEnum.categoryNoEventsText.localized
  
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
    self.screenStateEnum = .empty(title: noEventsText)
    
    observeRouterUpdates()
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
      navigationTitle = category?.title ?? ""
    }
  }
  
  private func showEditEventView(eventId: Identifier) {
    let eventScreenViewType = EventScreenViewType.edit(eventId: eventId)
    router.pushScreen(.event(eventScreenViewType))
  }
  
  private func showEventsWereNotFetchedAlert() {
    alertInfo = ErrorAlertInfo(message: TextEnum.eventsNotFetchedAlert.localized)
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
}
