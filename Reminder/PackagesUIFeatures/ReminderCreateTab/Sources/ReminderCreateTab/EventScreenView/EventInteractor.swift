//
//  EventInteractor.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class EventInteractor {
  private let createEventUseCase: CreateEventUseCaseProtocol
  private let editEventUseCase: EditEventUseCaseProtocol
  private let deleteEventUseCase: DeleteEventUseCaseProtocol
  private let fetchEventUseCase: FetchEventUseCaseProtocol
  private let fetchCategoryUseCase: FetchCategoryUseCaseProtocol
  private let fetchDefaultRemindTimeDateUseCase: FetchDefaultRemindTimeDateUseCaseProtocol
  
  private let presenter: EventPresenter
  private let store: EventViewStore

  public init(
    createEventUseCase: CreateEventUseCaseProtocol,
    editEventUseCase: EditEventUseCaseProtocol,
    deleteEventUseCase: DeleteEventUseCaseProtocol,
    fetchEventUseCase: FetchEventUseCaseProtocol,
    fetchCategoryUseCase: FetchCategoryUseCaseProtocol,
    fetchDefaultRemindTimeDateUseCase: FetchDefaultRemindTimeDateUseCaseProtocol,
    presenter: EventPresenter,
    store: EventViewStore
  ) {
    self.createEventUseCase = createEventUseCase
    self.editEventUseCase = editEventUseCase
    self.deleteEventUseCase = deleteEventUseCase
    self.fetchEventUseCase = fetchEventUseCase
    self.fetchCategoryUseCase = fetchCategoryUseCase
    self.fetchDefaultRemindTimeDateUseCase = fetchDefaultRemindTimeDateUseCase
    self.presenter = presenter
    self.store = store
    
    fetchDefaultRemindTimeDateAndUpdate()
  }
  
  public func onAppear() {
    Task { [weak self] in
      await self?.fetchNecessaryData()
    }
  }
  
  public func saveButtonTapped() {
    Task { [weak self] in
      guard let self else { return }
      presenter.presentSaving(true)
      do {
        let newCategoryId = try await self.saveEvent()
        self.notifyCategoryEventWasUpdated(newCategoryId: newCategoryId)
        presenter.presentSaving(false)
        closeView()
      } catch EventEntity.SaveEventError.titleShouldBeNotEmpty {
        presenter.presentSaving(false)
        presenter.presentEventTitleShouldBeNotEmptyAlert()
      } catch {
        presenter.presentSaving(false)
        presenter.presentEventWasNotSavedAlert()
      }
    }
  }
  
  public func cancelButtonTapped() {
    closeView()
  }
  
  public func deleteButtonTapped() {
    presenter.presentDeleteConfirmation { [weak self] in
      self?.deletingEventConfirmed()
    }
  }

  public func addRemindTimeButtonTapped() {
    if store.alertsSectionData.remindTimeDate2 == nil {
      store.alertsSectionData.remindTimeDate2 = store.alertsSectionData.defaultRemindTimeDate
    } else if store.alertsSectionData.remindTimeDate3 == nil {
      store.alertsSectionData.remindTimeDate3 = store.alertsSectionData.defaultRemindTimeDate
    }
  }

  public func removeRemindTimeDate2ButtonTapped() {
    if let remindTimeDate3 = store.alertsSectionData.remindTimeDate3 {
      store.alertsSectionData.remindTimeDate2 = remindTimeDate3
      store.alertsSectionData.remindTimeDate3 = nil
    } else {
      store.alertsSectionData.remindTimeDate2 = nil
    }
  }

  public func removeRemindTimeDate3ButtonTapped() {
    store.alertsSectionData.remindTimeDate3 = nil
  }
  
  private func deletingEventConfirmed() {
    Task { [weak self] in
      guard let self else { return }
      presenter.presentDeleting(true)
      do {
        try await self.performDeleteEvent()
        self.notifyCategoryEventWasUpdated(newCategoryId: nil)
        presenter.presentDeleting(false)
        closeView()
      } catch {
        presenter.presentDeleting(false)
        presenter.presentDeleteErrorAlert()
      }
    }
  }
  
  private func saveEvent() async throws -> Identifier? {
    let alertsSectionData: EventAlertsSectionData = store.alertsSectionData
    let detailsSectionData: EventDetailsSectionData = store.detailsSectionData
    try checkEventBeforeSaving(detailsSectionData: detailsSectionData)
    
    var newCategoryId: Identifier?
    switch store.eventScreenViewType {
    case .create(let categoryId):
      newCategoryId = try await createEvent(categoryId: categoryId, detailsSectionData: detailsSectionData, alertsSectionData: alertsSectionData)
    case .edit(let eventId):
      newCategoryId = try await editEvent(eventId: eventId, detailsSectionData: detailsSectionData, alertsSectionData: alertsSectionData)
    case .notVisible:
      break
    }
    return newCategoryId
  }
  
  private func performDeleteEvent() async throws {
    switch store.eventScreenViewType {
    case .edit(let eventId):
      try await deleteEventUseCase.execute(eventId: eventId)
    case .create, .notVisible:
      break
    }
  }
  
  private func createEvent(categoryId: Identifier, detailsSectionData: EventDetailsSectionData, alertsSectionData: EventAlertsSectionData) async throws -> Identifier? {
    let title = detailsSectionData.eventTitle
    let comment = detailsSectionData.eventComment
    let date = detailsSectionData.eventDate
    let remindRepeat = alertsSectionData.remindRepeat
    let remindTimeDate1 = alertsSectionData.remindTimeDate1
    let remindTimeDate2 = alertsSectionData.remindTimeDate2
    let remindTimeDate3 = alertsSectionData.remindTimeDate3
    let newCategoryId = try await createEventUseCase.execute(
      categoryId: categoryId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat,
      remindTimeDate1: remindTimeDate1,
      remindTimeDate2: remindTimeDate2,
      remindTimeDate3: remindTimeDate3
    )
    return newCategoryId
  }
  
  private func editEvent(eventId: Identifier, detailsSectionData: EventDetailsSectionData, alertsSectionData: EventAlertsSectionData) async throws -> Identifier? {
    let title = detailsSectionData.eventTitle
    let comment = detailsSectionData.eventComment
    let date = detailsSectionData.eventDate
    let remindRepeat = alertsSectionData.remindRepeat
    let remindTimeDate1 = alertsSectionData.remindTimeDate1
    let remindTimeDate2 = alertsSectionData.remindTimeDate2
    let remindTimeDate3 = alertsSectionData.remindTimeDate3
    let newCategoryId = try await editEventUseCase.execute(
      eventId: eventId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat,
      remindTimeDate1: remindTimeDate1,
      remindTimeDate2: remindTimeDate2,
      remindTimeDate3: remindTimeDate3
    )
    return newCategoryId
  }
  
  private func fetchNecessaryData() async {
    var eventId: Identifier?
    var categoryId: Identifier?
    
    switch store.eventScreenViewType {
    case .create(let categoryId_):
      categoryId = categoryId_
    case .edit(let eventId_):
      eventId = eventId_
    case .notVisible:
      break
    }
    
    if let eventId {
      let event = await fetchEventAndUpdateOrClose(eventId: eventId)
      if let event, let categoryId_ = event.categoryId {
        categoryId = categoryId_
      }
    }
    
    if let categoryId {
      await fetchCategoryAndUpdateOrClose(categoryId: categoryId)
    }
  }
  
  private func fetchEventAndUpdateOrClose(eventId: Identifier) async -> Event? {
    do {
      let event = try await fetchEventUseCase.execute(eventId: eventId)
      presenter.presentEvent(event)
      presenter.presentViewBlocked(false)
      return event
    } catch {
      presenter.presentEventWasNotFoundAlert { [weak self] in
        self?.closeView()
      }
      return nil
    }
  }
  
  private func fetchCategoryAndUpdateOrClose(categoryId: Identifier) async -> Void {
    do {
      let category = try await fetchCategoryUseCase.execute(categoryId: categoryId)
      presenter.presentViewBlocked(false)
      if let category {
        presenter.presentCategory(category)
      }
    } catch {
      presenter.presentCategoryWasNotFoundAlert { [weak self] in
        self?.closeView()
      }
      return
    }
  }
  
  private func fetchDefaultRemindTimeDateAndUpdate() {
    let defaultRemindTimeDate = fetchDefaultRemindTimeDateUseCase.execute()
    presenter.presentDefaultRemindTimeDate(defaultRemindTimeDate: defaultRemindTimeDate)
  }

  private func notifyCategoryEventWasUpdated(newCategoryId: Identifier?) {
    store.router.categoryEventWasUpdated(newCategoryId: newCategoryId)
  }

  private func closeView() {
    store.router.popScreen()
  }
  
  func checkEventBeforeSaving(detailsSectionData: EventDetailsSectionData) throws {
    let eventTitle = detailsSectionData.eventTitle
    guard !eventTitle.isEmpty else {
      throw EventEntity.SaveEventError.titleShouldBeNotEmpty
    }
  }
}
