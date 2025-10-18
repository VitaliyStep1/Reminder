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
  @Published var remindRepeat: RemindRepeatEnum

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

  let remindRepeatOptions = RemindRepeatEnum.allCases
  
  var category: ReminderDomainContracts.Category?
  
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
    self.remindRepeat = .everyYear
    
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
    
    fetchEventIfNeededAndCategory()
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
    let remindRepeat = self.remindRepeat
    guard !title.isEmpty else {
      throw CategoryEventEntity.CreateEventError.titleShouldBeNotEmpty
    }
    try await createEventUseCase.execute(
      categoryId: categoryId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat
    )
  }

  private func editEvent(eventId: Identifier) async throws {
    let title = self.title
    let comment = self.comment
    let date = self.date
    let remindRepeat = self.remindRepeat
    try await editEventUseCase.execute(
      eventId: eventId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat
    )
  }
  
  private func closeView() {
    closeViewHandler()
  }
  
  private func fetchEventIfNeededAndCategory() {
    var eventId: Identifier?
    var categoryId: Identifier?
    switch type {
    case .create(let categoryId_):
      categoryId = categoryId_
    case .edit(let eventId_):
      eventId = eventId_
    default:
      break
    }
    Task {
      if let eventId {
        let event = await fetchEventAndUpdateOrClose(eventId: eventId)
        if let event, let categoryId_ = event.categoryId {
          categoryId = categoryId_
        }
      }
      if let categoryId {
        let category = await fetchCategoryAndUpdateOrClose(categoryId: categoryId)
        
      }
    }
  }
  
  //TODO: Refactor
  private func fetchCategoryAndUpdateOrClose(categoryId: Identifier) async -> ReminderDomainContracts.Category? {
    let category = try? await fetchCategoryUseCase.execute(categoryId: categoryId)
    guard let category else {
      isViewBlocked = true
      showCategoryWasNotFoundAlert { [weak self] in
        self?.closeView()
      }
      return nil
    }
    updateForCategory(category: category)
    return category
  }
  
  private func updateForCategory(category: ReminderDomainContracts.Category) {
    
  }
  
  //TODO: Refactor
  private func fetchEventAndUpdateOrClose(eventId: Identifier) async -> Event? {
      let event = try? await fetchEventUseCase.execute(eventId: eventId)
      guard let event else {
        isViewBlocked = true
        showEventWasNotFoundAlert { [weak self] in
          self?.closeView()
        }
        return nil
      }
      self.title = event.title
      self.date = event.date
      self.comment = event.comment
      self.remindRepeat = event.remindRepeat
    return event
  }

  func remindRepeatTitle(for remindRepeat: RemindRepeatEnum) -> String {
    switch remindRepeat {
    case .everyYear:
      return "Every Year"
    case .everyMonth:
      return "Every Month"
    case .everyDay:
      return "Every Day"
    case .notRepeat:
      return "Not Repeat"
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
  
  private func showCategoryWasNotFoundAlert(completion: @escaping (() -> Void)) {
    alertInfo = AlertInfo(message: "Category was not found", completion: completion)
    isAlertVisible = true
  }
}
