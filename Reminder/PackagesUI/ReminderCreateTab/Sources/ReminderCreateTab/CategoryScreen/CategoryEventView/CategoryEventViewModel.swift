//
//  CategoryEventViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import Foundation
import ReminderPersistence
import ReminderDomain
import ReminderNavigationContracts

@MainActor
public class CategoryEventViewModel: ObservableObject {
  let dataService: DataServiceProtocol?
  let type: CategoryEventViewType
  let eventsWereChangedHandler: () -> Void
  let closeViewHandler: () -> Void

  @Published var title: String
  @Published var date: Date
  @Published var comment: String
  
  @Published var isSaving = false
  @Published var isDeleting = false
  @Published var isViewBlocked = false
  
  @Published var isAlertVisible: Bool = false
  var alertInfo: AlertInfo = AlertInfo(message: "")
  
  @Published var isConfirmationDialogVisible: Bool = false
  var confirmationDialogInfo: ConfirmationDialogInfo = ConfirmationDialogInfo(title: "", message: "")
  
  let viewTitle: String
  let isDeleteButtonVisible: Bool
  let saveButtonTitle: String
  let cancelButtonTitle = "Cancel"
  let deleteButtonTitle = "Delete"
  
  
  public init(dataService: DataServiceProtocol?, type: CategoryEventViewType, eventsWereChangedHandler: @escaping () -> Void, closeViewHandler: @escaping () -> Void) {
    self.dataService = dataService
    self.type = type
    self.eventsWereChangedHandler = eventsWereChangedHandler
    self.closeViewHandler = closeViewHandler
    
    self.title = ""
    self.date = Date()
    self.comment = ""
    
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
      changeIsSaving(true)
      do {
        try await saveEvent()
        eventsWereChangedHandler()
        changeIsSaving(false)
        closeView()
      }
      catch {
        changeIsSaving(false)
        showEventWasNotSavedAlert()
      }
    }
  }
  
  func cancelButtonTapped() {
    closeView()
  }
  
  func deleteButtonTapped() {
    showDeleteConfirmation()
  }
  
  private func showDeleteConfirmation() {
    confirmationDialogInfo = ConfirmationDialogInfo(title: "Delete this event?", message: "This action cannot be undone.", deleteButtonHandler: { [weak self] in
      self?.deletingEventConfirmed()
    })
    isConfirmationDialogVisible = true
  }
  
  private func deletingEventConfirmed() {
    Task {
      changeIsDeleting(true)
      do {
        try await deleteEvent()
        eventsWereChangedHandler()
        changeIsDeleting(false)
        closeView()
      }
      catch {
        changeIsDeleting(false)
        showDeleteErrorAlert()
      }
    }
  }
  
  private func changeIsSaving(_ isSaving: Bool) {
    self.isSaving = isSaving
  }
  
  private func changeIsDeleting(_ isDeleting: Bool) {
    self.isDeleting = isDeleting
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
  
  private func deleteEvent() async throws {
    switch type {
    case .edit(let eventId):
      try await deleteEvent(eventId: eventId)
    default:
      break
    }
  }
  
  private func deleteEvent(eventId: ObjectId) async throws {
    guard let dataService else {
      //TODO : Throw error
      return
    }
    try await dataService.deleteEvent(eventId: eventId)
  }
  
  private func createEvent(categoryId: ObjectId) async throws {
    guard let dataService else {
      //TODO : Throw error
      return
    }
    
    let title = self.title
    let comment = self.comment
    let date = self.date
    guard !title.isEmpty else {
      throw CategoryEventEntity.CreateEventError.titleShouldBeNotEmpty
    }
    try await dataService.createEvent(categoryId: categoryId, title: title, date: date, comment: comment)
  }
  
  private func editEvent(eventId: ObjectId) async throws {
    guard let dataService else {
      //TODO : Throw error
      return
    }
    let title = self.title
    let comment = self.comment
    let date = self.date
    try await dataService.editEvent(eventId: eventId, title: title, date: date, comment: comment)
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
    guard let dataService else {
      //TODO : Throw error
      return
    }
    Task {
      let event = try? await dataService.fetchEvent(eventId: eventId)
      guard let event else {
        isViewBlocked = true
        showEventWasNotFoundAlert { [weak self] in
          self?.closeView()
        }
        return
      }
      self.title = event.title
      self.date = event.date
      self.comment = event.comment
    }
  }
  
  private func showEventWasNotSavedAlert() {
    alertInfo = AlertInfo(message: "Event was not saved")
    isAlertVisible = true
  }
  
  private func showDeleteErrorAlert() {
    alertInfo = AlertInfo(message: "Deleting event failed")
    isAlertVisible = true
  }
  
  private func showEventWasNotFoundAlert(completion: @escaping (() -> Void)) {
    alertInfo = AlertInfo(message: "Event was not found", completion: completion)
    isAlertVisible = true
  }
}
