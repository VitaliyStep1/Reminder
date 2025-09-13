//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
  var dataService: DataServiceProtocol?
  let categoryId: ObjectId
  
  @Published var eventEntities: [CategoryEventEntity] = []
  @Published var navigationTitle: String = "Events"
  
  @Published var createEventViewIsPresented = false
  var createEventViewTitle = ""
  var createEventViewComment = ""
  
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
    createEventViewIsPresented = false
    createEvent()
  }
  
  private func showCreateEventView() {
    createEventViewIsPresented = true
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
