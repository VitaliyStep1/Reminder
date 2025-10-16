//
//  CategoryEventViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 22.09.2025.
//

import Foundation
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public class CategoryEventViewModel: ObservableObject {
  let createEventUseCase: CreateEventUseCaseProtocol
  let editEventUseCase: EditEventUseCaseProtocol
  let deleteEventUseCase: DeleteEventUseCaseProtocol
  let fetchEventUseCase: FetchEventUseCaseProtocol
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
  
  
  public init(
    createEventUseCase: CreateEventUseCaseProtocol,
    editEventUseCase: EditEventUseCaseProtocol,
    deleteEventUseCase: DeleteEventUseCaseProtocol,
    fetchEventUseCase: FetchEventUseCaseProtocol,
    type: CategoryEventViewType,
    eventsWereChangedHandler: @escaping () -> Void,
    closeViewHandler: @escaping () -> Void
  ) {
    self.createEventUseCase = createEventUseCase
    self.editEventUseCase = editEventUseCase
    self.deleteEventUseCase = deleteEventUseCase
    self.fetchEventUseCase = fetchEventUseCase
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
        } catch {
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
          try await performDeleteEvent()
          eventsWereChangedHandler()
          changeIsDeleting(false)
          closeView()
        } catch {
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
  
  private func performDeleteEvent() async throws {
    switch type {
    case .edit(let eventId):
      try await deleteEventUseCase.execute(eventId: eventId)
    default:
      break
    }
  }

  private func createEvent(categoryId: Identifier) async throws {
    let title = self.title
    let comment = self.comment
    let date = self.date
    guard !title.isEmpty else {
      throw CategoryEventEntity.CreateEventError.titleShouldBeNotEmpty
    }
    try await createEventUseCase.execute(categoryId: categoryId, title: title, date: date, comment: comment)
  }

  private func editEvent(eventId: Identifier) async throws {
    let title = self.title
    let comment = self.comment
    let date = self.date
    try await editEventUseCase.execute(eventId: eventId, title: title, date: date, comment: comment)
  }
  
  private func closeView() {
    closeViewHandler()
  }
  
  private func fetchEventIfNeeded() {
    if case .edit(let eventId) = type {
      fetchEvent(eventId: eventId)
    }
  }
  
  private func fetchEvent(eventId: Identifier) {
    Task {
      let event = try? await fetchEventUseCase.execute(eventId: eventId)
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
