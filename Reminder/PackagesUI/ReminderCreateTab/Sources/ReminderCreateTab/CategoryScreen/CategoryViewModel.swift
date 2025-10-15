//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import Combine
import ReminderDomainContracts
import ReminderNavigationContracts

@MainActor
public class CategoryViewModel: ObservableObject {
  var dataService: DataServiceProtocol
  let categoryId: Identifier
  
  @Published var entityEvents: [CategoryEntity.Event] = []
  @Published var navigationTitle: String = ""
  @Published var isAlertVisible: Bool = false
  var alertInfo: AlertInfo = AlertInfo(message: "")
  
  var createEventViewTitle = ""
  var createEventViewDate = Date()
  var createEventViewComment = ""
  
  let eventViewSubject = PassthroughSubject<CategoryEventViewType, Never>()
  
  public init(categoryId: Identifier, dataService: DataServiceProtocol) {
    self.categoryId = categoryId
    self.dataService = dataService
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
  
  func categoryEventWasUpdated() {
    updateEventList()
  }
  
  func closeViewWasCalled() {
    hideCreateEventView()
  }
  
  private func showCreateEventView() {
    eventViewSubject.send(.create(categoryId: categoryId))
  }
  
  private func hideCreateEventView() {
    eventViewSubject.send(.notVisible)
  }
  
  private func updateEventList() {
    Task {
      do {
        let events = try await dataService.fetchEvents(categoryId: categoryId)
        let entityEvents: [CategoryEntity.Event] = events.map { event in
          let date = event.date.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits))
          return CategoryEntity.Event(id: event.id, title: event.title, date: date, comment: event.comment)
        }
        
        self.entityEvents = entityEvents
      }
      catch {
          showEventsWereNotFetchedAlert()
      }
    }
  }
  
  private func updateNavigationTitle() {
    Task {
      let category = try? await dataService.fetchCategory(categoryId: categoryId)
      navigationTitle = category?.title ?? ""
    }
  }
  
  private func showEditEventView(eventId: Identifier) {
    eventViewSubject.send(.edit(eventId: eventId))
  }
  
  private func showEventsWereNotFetchedAlert() {
    alertInfo = AlertInfo(message: "Events were not fetched")
    isAlertVisible = true
  }
}
