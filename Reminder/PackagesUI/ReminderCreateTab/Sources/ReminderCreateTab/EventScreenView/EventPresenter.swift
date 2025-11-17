//
//  EventPresenter.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import Combine
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class EventPresenter {
  private let store: EventViewStore
  private var cancellables = Set<AnyCancellable>()

  public init(store: EventViewStore) {
    self.store = store
    configureBindings()
    configureView()
  }
  
  public func presentSaving(_ isSaving: Bool) {
    store.buttonsData.isSaving = isSaving
  }
  
  public func presentDeleting(_ isDeleting: Bool) {
    store.buttonsData.isDeleting = isDeleting
  }
  
  public func presentViewBlocked(_ isBlocked: Bool) {
    store.isViewBlocked = isBlocked
  }
  
  public func presentDeleteConfirmation(deleteHandler: @escaping () -> Void) {
    store.confirmationDialogInfo = DeleteConfirmationDialogInfo(
      title: TextEnum.deleteEventTitle.localized,
      message: TextEnum.deleteEventMessage.localized,
      deleteButtonHandler: deleteHandler
    )
    store.isConfirmationDialogVisible = true
  }
  
  public func presentEvent(_ event: Event) {
    store.detailsSectionData.eventTitle = event.title
    store.detailsSectionData.eventDate = event.date
    store.detailsSectionData.eventComment = event.comment
    store.alertsSectionData.remindRepeat = event.remindRepeat
    store.alertsSectionData.remindTimeDate1 = event.remindTimeDate1
    store.alertsSectionData.remindTimeDate2 = event.remindTimeDate2
    store.alertsSectionData.remindTimeDate3 = event.remindTimeDate3
  }
  
  public func presentCategory(_ category: ReminderDomainContracts.Category) {
    store.category = category
    
    let options = category.categoryRepeat.chooseOptions
    if options.isEmpty {
      let remindRepeatText = remindRepeatTitle(for: store.alertsSectionData.remindRepeat)
      store.alertsSectionData.repeatRepresentationEnum = .text(text: remindRepeatText)
    } else {
      let remindRepeatValues = options
      let remindRepeatTitles = Dictionary(uniqueKeysWithValues: remindRepeatValues.map { ($0, remindRepeatTitle(for: $0)) })
      store.alertsSectionData.repeatRepresentationEnum = .picker(values: remindRepeatValues, titles: remindRepeatTitles)
    }

    if case .create = store.eventScreenViewType {
      store.alertsSectionData.remindRepeat = category.categoryRepeat.defaultRemindRepeat
    }

    if let firstOption = options.first, !options.contains(store.alertsSectionData.remindRepeat) {
      store.alertsSectionData.remindRepeat = firstOption
    }
  }
  
  public func presentEventTitleShouldBeNotEmptyAlert() {
    presentAlert(message: TextEnum.eventTitleEmptyAlert.localized)
  }

  public func presentEventWasNotSavedAlert() {
    presentAlert(message: TextEnum.eventNotSavedAlert.localized)
  }

  public func presentDeleteErrorAlert() {
    presentAlert(message: TextEnum.eventDeleteFailedAlert.localized)
  }

  public func presentEventWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: TextEnum.eventNotFoundAlert.localized, completion: completion)
  }

  public func presentCategoryWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: TextEnum.categoryNotFoundAlert.localized, completion: completion)
  }
  
  public func presentAlert(message: String, completion: (() -> Void)? = nil) {
    store.alertInfo = ErrorAlertInfo(message: message, completion: completion)
    store.isAlertVisible = true
  }

  public func presentDefaultRemindTimeDate(defaultRemindTimeDate: Date) {
    store.alertsSectionData.defaultRemindTimeDate = defaultRemindTimeDate
    store.alertsSectionData.remindTimeDate1 = defaultRemindTimeDate
  }
  
  private func configureView() {
    switch store.eventScreenViewType {
    case .create:
      store.screenTitleData.screenTitle = TextEnum.createEventScreenTitle.localized
      store.buttonsData.isDeleteButtonVisible = false
      store.buttonsData.saveButtonTitle = TextEnum.createEventButtonTitle.localized
    case .edit:
      store.screenTitleData.screenTitle = TextEnum.editEventScreenTitle.localized
      store.buttonsData.isDeleteButtonVisible = true
      store.buttonsData.saveButtonTitle = TextEnum.saveEventButtonTitle.localized
    case .notVisible:
      store.screenTitleData.screenTitle = ""
      store.buttonsData.isDeleteButtonVisible = false
      store.buttonsData.saveButtonTitle = ""
    }
  }

  private func configureBindings() {
    store.alertsSectionData.$remindRepeat
      .receive(on: RunLoop.main)
      .sink { [weak self] remindRepeat in
        self?.updateRepeatRepresentationIfNeeded(for: remindRepeat)
      }
      .store(in: &cancellables)
  }

  private func updateRepeatRepresentationIfNeeded(for remindRepeat: RemindRepeatEnum) {
    guard case .text = store.alertsSectionData.repeatRepresentationEnum else { return }
    store.alertsSectionData.repeatRepresentationEnum = .text(text: remindRepeatTitle(for: remindRepeat))
  }
  
  private func remindRepeatTitle(for remindRepeat: RemindRepeatEnum) -> String {
    switch remindRepeat {
    case .everyYear:
      return TextEnum.yearTitle.localized
    case .everyMonth:
      return TextEnum.monthTitle.localized
    case .everyDay:
      return TextEnum.dayTitle.localized
    case .notRepeat:
      return TextEnum.notRepeatTitle.localized
    }
  }
}
