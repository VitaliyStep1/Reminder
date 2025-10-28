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
  
  @Published var entityEvents: [CategoryEntity.Event] = []
  @Published var navigationTitle: String = ""
  @Published var isAlertVisible: Bool = false
  var router: CreateTabRouterProtocol
  
  var alertInfo: AlertInfo = AlertInfo(message: "")
  
  var createEventViewTitle = ""
  var createEventViewDate = Date()
  var createEventViewComment = ""
  
  public init(
    categoryId: Identifier,
    fetchEventsUseCase: FetchEventsUseCaseProtocol,
    fetchCategoryUseCase: FetchCategoryUseCaseProtocol, router: CreateTabRouterProtocol
  ) {
    self.categoryId = categoryId
    self.fetchEventsUseCase = fetchEventsUseCase
    self.fetchCategoryUseCase = fetchCategoryUseCase
    self.router = router
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
  
  func categoryEventWasUpdated(newCategoryId: Identifier?) {
    if let newCategoryId {
      updateCategoryId(newCategoryId: newCategoryId)
    } else {
      updateEventList()
    }
  }
  
  private func updateCategoryId(newCategoryId: Identifier) {
    self.categoryId = newCategoryId
    
    updateEventList()
    updateNavigationTitle()
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
            return CategoryEntity.Event(id: event.id, title: event.title, date: date, comment: event.comment)
          }

          self.entityEvents = entityEvents
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
    alertInfo = AlertInfo(message: "Events were not fetched")
    isAlertVisible = true
  }
}
