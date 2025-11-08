//
//  EventViewStore.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import ReminderDomainContracts
import ReminderNavigationContracts

@MainActor
public final class EventViewStore: ObservableObject {
  public let eventScreenViewType: EventScreenViewType

  public let eventData: EventData
  @Published public var defaultRemindTimeDate: Date

  @Published public var isRemindTime2ViewVisible: Bool
  @Published public var isRemindTime3ViewVisible: Bool
  @Published public var isAddRemindTimeButtonVisible: Bool
  
  @Published public var isSaving: Bool
  @Published public var isDeleting: Bool
  @Published public var isViewBlocked: Bool
  
  @Published public var isAlertVisible: Bool
  public var alertInfo: ErrorAlertInfo
  
  @Published public var isConfirmationDialogVisible: Bool
  public var confirmationDialogInfo: ConfirmationDialogInfo
  
  @Published public var viewTitle: String
  @Published public var isDeleteButtonVisible: Bool
  @Published public var saveButtonTitle: String
  public let cancelButtonTitle: String
  public let deleteButtonTitle: String

  public var category: ReminderDomainContracts.Category?

  @Published var repeatRepresentationEnum: EventEntity.RepeatRepresentationEnum
  let router: any CreateTabRouterProtocol

  public init(eventScreenViewType: EventScreenViewType, router: any CreateTabRouterProtocol) {
    self.eventScreenViewType = eventScreenViewType
    self.eventData = EventData(
      title: "",
      date: Date(),
      comment: "",
      remindRepeat: .everyYear,
      remindTimeDate1: Date(),
      remindTimeDate2: nil,
      remindTimeDate3: nil
    )
    self.defaultRemindTimeDate = Date()
    self.isRemindTime2ViewVisible = false
    self.isRemindTime3ViewVisible = false
    self.isAddRemindTimeButtonVisible = true
    self.isSaving = false
    self.isDeleting = false
    self.isViewBlocked = false
    self.isAlertVisible = false
    self.alertInfo = ErrorAlertInfo(message: "")
    self.isConfirmationDialogVisible = false
    self.confirmationDialogInfo = ConfirmationDialogInfo(title: "", message: "")
    self.viewTitle = ""
    self.isDeleteButtonVisible = false
    self.saveButtonTitle = ""
    self.cancelButtonTitle = "Cancel"
    self.deleteButtonTitle = "Delete"
    self.category = nil
    self.repeatRepresentationEnum = .text(text: "")
    self.router = router
    
    eventData.onRemindTimeDatesChange = { [weak self] in
      self?.updateRemindTimeVisibility()
    }

    updateRemindTimeVisibility()
  }

  private func updateRemindTimeVisibility() {
    isRemindTime2ViewVisible = eventData.remindTimeDate2 != nil
    isRemindTime3ViewVisible = eventData.remindTimeDate3 != nil
    isAddRemindTimeButtonVisible = !isRemindTime3ViewVisible
  }
}
