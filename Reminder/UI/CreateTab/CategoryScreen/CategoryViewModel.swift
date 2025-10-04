//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import Combine

@MainActor
class CategoryViewModel: ObservableObject {
  var dataService: DataServiceProtocol?
  let categoryId: ObjectId
  
  @Published var entityEvents: [CategoryEntity.Event] = []
  @Published var navigationTitle: String = ""
  @Published var isAlertVisible: Bool = false
  var alertInfo: AlertInfo = AlertInfo(message: "")
  
  var createEventViewTitle = ""
  var createEventViewDate = Date()
  var createEventViewComment = ""
  
  let eventViewSubject = PassthroughSubject<CategoryEventViewType, Never>()
  
  init(categoryId: ObjectId) {
    self.categoryId = categoryId
  }
  
  func setup(dataService: DataServiceProtocol) {
    self.dataService = dataService
    
    updateEventList()
    updateNavigationTitle()
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
  
  func eventTapped(eventId: ObjectId) {
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
    guard let dataService else {
      return
    }
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
    guard let dataService else {
      return
    }
    Task {
      let category = try? await dataService.fetchCategory(categoryId: categoryId)
      navigationTitle = category?.title ?? ""
    }
  }
  
  private func showEditEventView(eventId: ObjectId) {
    eventViewSubject.send(.edit(eventId: eventId))
  }
  
  private func showEventsWereNotFetchedAlert() {
    alertInfo = AlertInfo(message: "Events were not fetched")
    isAlertVisible = true
  }
}
