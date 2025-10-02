//
//  CategoryEventViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import Foundation


class CategoryEventViewModel: ObservableObject {
  let dataService: DataServiceProtocol
  let type: CategoryEventViewType
  let eventsWereChangedHandler: () -> Void
  let closeViewHandler: () -> Void

  @Published var title: String
  @Published var date: Date
  @Published var comment: String
  
  let viewTitle: String
  let isDeleteButtonVisible: Bool
  let saveButtonTitle: String
  let cancelButtonTitle = "Cancel"
  let deleteButtonTitle = "Delete"
  
  
  init(dataService: DataServiceProtocol, type: CategoryEventViewType, event: Event? = nil, eventsWereChangedHandler: @escaping () -> Void, closeViewHandler: @escaping () -> Void) {
    self.dataService = dataService
    self.type = type
    self.eventsWereChangedHandler = eventsWereChangedHandler
    self.closeViewHandler = closeViewHandler
    
    if let event {
      self.title = event.title
      self.date = event.date
      self.comment = event.comment
    } else {
      self.title = ""
      self.date = Date()
      self.comment = ""
    }
    
    switch type {
    case .create:
      viewTitle = "Create Event"
      isDeleteButtonVisible = false
      saveButtonTitle = "Create"
    case .edit:
      viewTitle = "Edit Event"
      isDeleteButtonVisible = true
      saveButtonTitle = "Save"
    default:
      viewTitle = ""
      isDeleteButtonVisible = false
      saveButtonTitle = ""
    }
    
    fetchEventIfNeeded()
  }
  
  func saveButtonTapped() {
    Task {
      do {
        try await saveEvent()
        eventsWereChangedHandler()
        closeView()
      }
      catch {
        // Show error alert
      }
    }
  }
  
  func cancelButtonTapped() {
    closeView()
  }
  
  func deleteButtonTapped() {
    deleteEvent()
    eventsWereChangedHandler()
    closeView()
  }
  
  private func saveEvent() async throws {
    switch type {
    case .create(let categoryId):
      try await createEvent(categoryId: categoryId)
    case .edit(let eventId):
      try await editEvent(eventId: eventId)
    default:
      break
    }
    
  }
  
  private func deleteEvent() {
    
  }
  
  private func createEvent(categoryId: ObjectId) async throws {
    let title = self.title
    let comment = self.comment
    let date = self.date
    try await self.dataService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
  
  private func editEvent(eventId: ObjectId) async throws {
    let title = self.title
    let comment = self.comment
    let date = self.date
    try await self.dataService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
  }
  
  private func eventWasCreatedSuccessfully() {
//    createEventViewTitle = ""
//    createEventViewComment = ""
//    updateEventList()
  }
  
  private func showEventWasNotCreatedAlert() {
    
  }
  
  private func closeView() {
    closeViewHandler()
  }
  
  private func fetchEventIfNeeded() {
    if case .edit(let eventId) = type {
      fetchEvent(eventId: eventId)
    }
  }
  
  private func fetchEvent(eventId: ObjectId) {
    Task {
      let event = try? await dataService.fetchEvent(eventId: eventId)
      if let event {
        self.title = event.title
        self.date = event.date
        self.comment = event.comment
      } else {
        //TODO:
        // Close view
        // Show error alert
      }
    }
  }
}
