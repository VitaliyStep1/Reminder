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
  private var locale: Locale = .current
  private var cancellables = Set<AnyCancellable>()

  public init(store: EventViewStore) {
    self.store = store
    configureBindings()
    configureView()
  }

  public func updateLocale(_ locale: Locale) {
    self.locale = locale
    store.updateLocale(locale)
    configureView()
    updateRepeatRepresentationIfNeeded(for: store.alertsSectionData.remindRepeat)
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
      title: String(localized: Localize.deleteEventTitle.localed(locale)),
      message: String(localized: Localize.deleteEventMessage.localed(locale)),
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
    presentAlert(message: String(localized: Localize.eventTitleEmptyAlert.localed(locale)))
  }

  public func presentEventWasNotSavedAlert() {
    presentAlert(message: String(localized: Localize.eventNotSavedAlert.localed(locale)))
  }

  public func presentDeleteErrorAlert() {
    presentAlert(message: String(localized: Localize.eventDeleteFailedAlert.localed(locale)))
  }

  public func presentEventWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: String(localized: Localize.eventNotFoundAlert.localed(locale)), completion: completion)
  }

  public func presentCategoryWasNotFoundAlert(completion: @escaping (() -> Void)) {
    presentViewBlocked(true)
    presentAlert(message: String(localized: Localize.categoryNotFoundAlert.localed(locale)), completion: completion)
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
      store.screenTitleData.screenTitle = String(localized: Localize.createEventScreenTitle.localed(locale))
      store.buttonsData.isDeleteButtonVisible = false
      store.buttonsData.saveButtonTitle = String(localized: Localize.createEventButtonTitle.localed(locale))
    case .edit:
      store.screenTitleData.screenTitle = String(localized: Localize.editEventScreenTitle.localed(locale))
      store.buttonsData.isDeleteButtonVisible = true
      store.buttonsData.saveButtonTitle = String(localized: Localize.saveEventButtonTitle.localed(locale))
      store.buttonsData.deleteButtonTitle = String(localized: Localize.deleteButtonTitle.localed(locale))
    case .notVisible:
      store.screenTitleData.screenTitle = ""
      store.buttonsData.isDeleteButtonVisible = false
      store.buttonsData.saveButtonTitle = ""
    }

    store.buttonsData.cancelButtonTitle = String(localized: Localize.cancelTitle.localed(locale))
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
      return String(localized: Localize.yearTitle.localed(locale))
    case .everyMonth:
      return String(localized: Localize.monthTitle.localed(locale))
    case .everyDay:
      return String(localized: Localize.dayTitle.localed(locale))
    case .notRepeat:
      return String(localized: Localize.notRepeatTitle.localed(locale))
    }
  }
}
