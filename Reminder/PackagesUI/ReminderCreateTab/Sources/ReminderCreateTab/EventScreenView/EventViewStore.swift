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

  @Published public var eventTitle: String
  @Published public var eventDate: Date
  @Published public var eventComment: String
  @Published public var eventRemindRepeat: RemindRepeatEnum
  @Published public var remindTimeDate1: Date
  @Published public var remindTimeDate2: Date? { didSet { updateRemindTimeVisibility() } }
  @Published public var remindTimeDate3: Date? { didSet { updateRemindTimeVisibility() } }
  @Published public var defaultRemindTimeDate: Date

  @Published public var isRemindTime2ViewVisible: Bool
  @Published public var isRemindTime3ViewVisible: Bool
  @Published public var isAddRemindTimeButtonVisible: Bool
  
  @Published public var isSaving: Bool
  @Published public var isDeleting: Bool
  @Published public var isViewBlocked: Bool
  
  @Published public var isAlertVisible: Bool
  public var alertInfo: AlertInfo
  
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
    self.eventTitle = ""
    self.eventDate = Date()
    self.eventComment = ""
    self.eventRemindRepeat = .everyYear
    self.remindTimeDate1 = Date()
    self.remindTimeDate2 = nil
    self.remindTimeDate3 = nil
    self.defaultRemindTimeDate = Date()
    self.isRemindTime2ViewVisible = false
    self.isRemindTime3ViewVisible = false
    self.isAddRemindTimeButtonVisible = true
    self.isSaving = false
    self.isDeleting = false
    self.isViewBlocked = false
    self.isAlertVisible = false
    self.alertInfo = AlertInfo(message: "")
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
    
    updateRemindTimeVisibility()
  }

  private func updateRemindTimeVisibility() {
    isRemindTime2ViewVisible = remindTimeDate2 != nil
    isRemindTime3ViewVisible = remindTimeDate3 != nil
    isAddRemindTimeButtonVisible = !isRemindTime3ViewVisible
  }
}
