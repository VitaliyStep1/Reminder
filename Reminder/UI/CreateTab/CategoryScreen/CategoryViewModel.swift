//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
  var dataService: DataServiceProtocol?
  let categoryId: ObjectId
  
  @Published var eventEntities: [CategoryEventEntity] = []
  @Published var navigationTitle: String = "Events"
  
  var createEventViewTitle = ""
  var createEventViewComment = ""
  
  let showCreateEventViewSubject = PassthroughSubject<Void, Never>()
  let hideCreateEventViewSubject = PassthroughSubject<Void, Never>()
  
  init(categoryId: ObjectId) {
    self.categoryId = categoryId
  }
  
  func setup(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }
  
  func viewAppeared() {
    updateEventList()
  }
  
  func viewTaskCalled() {
    updateEventList()
  }
  
  func addButtonTapped() {
    showCreateEventView()
  }
  
  func createEventViewCreateButtonTapped() {
    guard !createEventViewTitle.isEmpty else {
      showCreateEventViewTitleShouldBeNotNilAlert()
      return
    }
    hideCreateEventView()
    createEvent()
  }
  
  func createEventViewCancelButtonTapped() {
    createEventViewTitle = ""
    createEventViewComment = ""
    hideCreateEventView()
  }
  
  private func showCreateEventView() {
    showCreateEventViewSubject.send()
  }
  
  private func hideCreateEventView() {
    hideCreateEventViewSubject.send()
  }
  
  private func createEvent() {
    let title = createEventViewTitle
    let comment = createEventViewComment
    let date = Date()
    Task {
      do {
        try await self.dataService?.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
        await MainActor.run {
          eventWasCreatedSuccessfully()
        }
      }
      catch {
        print(error.localizedDescription)
        await MainActor.run {
          showEventWasNotCreatedAlert()
        }
      }
    }
  }
  
  private func eventWasCreatedSuccessfully() {
    createEventViewTitle = ""
    createEventViewComment = ""
    updateEventList()
  }
  
  private func updateEventList() {
    guard let dataService else {
      return
    }
    Task {
      do {
        let events = try await dataService.fetchEvents(categoryId: categoryId)
        let eventEntities = events.map { event in
          CategoryEventEntity(id: event.id, title: event.title, comment: event.comment)
        }
        
        await MainActor.run {
          self.eventEntities = eventEntities
        }
      }
      catch {
        showEventsWereNotFetchedAlert()
      }
    }
  }
  
  private func showEventWasNotCreatedAlert() {
    
  }
  
  private func showEventsWereNotFetchedAlert() {
    
  }
  
  private func showCreateEventViewTitleShouldBeNotNilAlert() {
    
  }
}
