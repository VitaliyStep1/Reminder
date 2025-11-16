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

  let screenTitleData: EventScreenTitleData
  let detailsSectionData: EventDetailsSectionData
  let alertsSectionData: EventAlertsSectionData
  let plannedSectionData: EventPlannedSectionData
  let buttonsData: EventButtonsData
  
  @Published public var isViewBlocked: Bool
  
  @Published public var isAlertVisible: Bool
  public var alertInfo: ErrorAlertInfo
  
  @Published public var isConfirmationDialogVisible: Bool
  public var confirmationDialogInfo: DeleteConfirmationDialogInfo

  public var category: ReminderDomainContracts.Category?
  
  let router: any CreateRouterProtocol

  public init(eventScreenViewType: EventScreenViewType, router: any CreateRouterProtocol) {
    self.eventScreenViewType = eventScreenViewType
    
    self.screenTitleData = EventScreenTitleData(screenTitle: "")
    self.detailsSectionData = EventDetailsSectionData(
      eventTitle: "",
      eventComment: "",
      eventDate: Date()
    )
    
    self.alertsSectionData = EventAlertsSectionData(
      repeatRepresentationEnum: .text(text: ""),
      remindRepeat: .everyYear,
      isRemindTime2ViewVisible: false,
      isRemindTime3ViewVisible: false,
      isAddRemindTimeButtonVisible: true,
      defaultRemindTimeDate: Date(),
      remindTimeDate1: Date(),
      remindTimeDate2: nil,
      remindTimeDate3: nil
    )
    
    self.plannedSectionData = EventPlannedSectionData(
      plannedRemindsRepresentationEnum: .noRemindPermission
    )
    
    self.buttonsData = EventButtonsData(
      isSaving: false,
      isDeleting: false,
      isDeleteButtonVisible: false,
      saveButtonTitle: "",
      cancelButtonTitle: "Cancel",
      deleteButtonTitle: "Delete"
    )
    
    self.isViewBlocked = false
    self.isAlertVisible = false
    self.alertInfo = ErrorAlertInfo(message: "")
    self.isConfirmationDialogVisible = false
    self.confirmationDialogInfo = DeleteConfirmationDialogInfo(title: "", message: "", deleteButtonHandler: {})
    self.category = nil
    self.router = router
  }
}
