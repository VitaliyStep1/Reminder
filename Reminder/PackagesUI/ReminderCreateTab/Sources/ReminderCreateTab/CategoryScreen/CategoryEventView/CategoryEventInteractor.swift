//
//  CategoryEventInteractor.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class CategoryEventInteractor {
  private let createEventUseCase: CreateEventUseCaseProtocol
  private let editEventUseCase: EditEventUseCaseProtocol
  private let deleteEventUseCase: DeleteEventUseCaseProtocol
  private let fetchEventUseCase: FetchEventUseCaseProtocol
  private let fetchCategoryUseCase: FetchCategoryUseCaseProtocol
  
  private let presenter: CategoryEventPresenter
  private let store: CategoryEventViewStore
  private let type: CategoryEventViewType
  private let eventsWereChangedHandler: () -> Void
  private let closeViewHandler: () -> Void
  
  public init(
    createEventUseCase: CreateEventUseCaseProtocol,
    editEventUseCase: EditEventUseCaseProtocol,
    deleteEventUseCase: DeleteEventUseCaseProtocol,
    fetchEventUseCase: FetchEventUseCaseProtocol,
    fetchCategoryUseCase: FetchCategoryUseCaseProtocol,
    presenter: CategoryEventPresenter,
    store: CategoryEventViewStore,
    type: CategoryEventViewType,
    eventsWereChangedHandler: @escaping () -> Void,
    closeViewHandler: @escaping () -> Void
  ) {
    self.createEventUseCase = createEventUseCase
    self.editEventUseCase = editEventUseCase
    self.deleteEventUseCase = deleteEventUseCase
    self.fetchEventUseCase = fetchEventUseCase
    self.fetchCategoryUseCase = fetchCategoryUseCase
    self.presenter = presenter
    self.store = store
    self.type = type
    self.eventsWereChangedHandler = eventsWereChangedHandler
    self.closeViewHandler = closeViewHandler
  }
  
  public func onAppear() {
    Task { [weak self] in
      await self?.fetchEventIfNeededAndCategory()
    }
  }
  
  public func saveButtonTapped() {
    Task { [weak self] in
      guard let self else { return }
      presenter.presentSaving(true)
      do {
        try await self.saveEvent()
        eventsWereChangedHandler()
        presenter.presentSaving(false)
        closeView()
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
  
  private func deletingEventConfirmed() {
    Task { [weak self] in
      guard let self else { return }
      presenter.presentDeleting(true)
      do {
        try await self.performDeleteEvent()
        eventsWereChangedHandler()
        presenter.presentDeleting(false)
        closeView()
      } catch {
        presenter.presentDeleting(false)
        presenter.presentDeleteErrorAlert()
      }
    }
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
    let title = store.title
    let comment = store.comment
    let date = store.date
    let remindRepeat = store.remindRepeat
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
    let title = store.title
    let comment = store.comment
    let date = store.date
    let remindRepeat = store.remindRepeat
    try await editEventUseCase.execute(
      eventId: eventId,
      title: title,
      date: date,
      comment: comment,
      remindRepeat: remindRepeat
    )
  }
  
  private func fetchEventIfNeededAndCategory() async {
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
  
  private func closeView() {
    closeViewHandler()
  }
}
