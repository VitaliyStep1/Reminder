//
//  CategoryEventPresenter.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import Combine
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class CategoryEventPresenter {
  private let store: CategoryEventViewStore
  private var cancellables = Set<AnyCancellable>()

  public init(store: CategoryEventViewStore) {
    self.store = store
    configureBindings()
    configureView()
  }
  
  public func presentSaving(_ isSaving: Bool) {
    store.isSaving = isSaving
  }
  
  public func presentDeleting(_ isDeleting: Bool) {
    store.isDeleting = isDeleting
  }
  
  public func presentViewBlocked(_ isBlocked: Bool) {
    store.isViewBlocked = isBlocked
  }
  
  public func presentDeleteConfirmation(deleteHandler: @escaping () -> Void) {
    store.confirmationDialogInfo = ConfirmationDialogInfo(
      title: "Delete this event?",
      message: "This action cannot be undone.",
      deleteButtonHandler: deleteHandler
    )
    store.isConfirmationDialogVisible = true
  }
  
  public func presentEvent(_ event: Event) {
    store.eventTitle = event.title
    store.eventDate = event.date
    store.eventComment = event.comment
    store.eventRemindRepeat = event.remindRepeat
  }
  
  public func presentCategory(_ category: ReminderDomainContracts.Category) {
    store.category = category
    
    let options = category.categoryRepeat.chooseOptions
    if options.isEmpty {
      let remindRepeatText = remindRepeatTitle(for: store.eventRemindRepeat)
      store.repeatRepresentationEnum = .text(text: remindRepeatText)
    } else {
      let remindRepeatValues = options
      let remindRepeatTitles = Dictionary(uniqueKeysWithValues: remindRepeatValues.map { ($0, remindRepeatTitle(for: $0)) })
      store.repeatRepresentationEnum = .picker(values: remindRepeatValues, titles: remindRepeatTitles)
    }
    
    if case .create = store.categoryEventViewType {
      store.eventRemindRepeat = category.categoryRepeat.defaultRemindRepeat
    }

    if let firstOption = options.first, !options.contains(store.eventRemindRepeat) {
      store.eventRemindRepeat = firstOption
    }
  }
  
  public func presentEventWasNotSavedAlert() {
    presentAlert(message: "Event was not saved")
  }
  
  public func presentDeleteErrorAlert() {
    presentAlert(message: "Deleting event failed")
  }
  
  public func presentEventWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: "Event was not found", completion: completion)
  }
  
  public func presentCategoryWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: "Category was not found", completion: completion)
  }
  
  public func presentAlert(message: String, completion: (() -> Void)? = nil) {
    store.alertInfo = AlertInfo(message: message, completion: completion)
    store.isAlertVisible = true
  }
  
  private func configureView() {
    switch store.categoryEventViewType {
    case .create:
      store.viewTitle = "Create Event"
      store.isDeleteButtonVisible = false
      store.saveButtonTitle = "Create"
    case .edit:
      store.viewTitle = "Edit Event"
      store.isDeleteButtonVisible = true
      store.saveButtonTitle = "Save"
    default:
      store.viewTitle = ""
      store.isDeleteButtonVisible = false
      store.saveButtonTitle = ""
    }
  }

  private func configureBindings() {
    store.$eventRemindRepeat
      .receive(on: RunLoop.main)
      .sink { [weak self] remindRepeat in
        self?.updateRepeatRepresentationIfNeeded(for: remindRepeat)
      }
      .store(in: &cancellables)
  }

  private func updateRepeatRepresentationIfNeeded(for remindRepeat: RemindRepeatEnum) {
    guard case .text = store.repeatRepresentationEnum else { return }
    store.repeatRepresentationEnum = .text(text: remindRepeatTitle(for: remindRepeat))
  }
  
  private func remindRepeatTitle(for remindRepeat: RemindRepeatEnum) -> String {
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
}
