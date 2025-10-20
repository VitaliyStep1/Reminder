//
//  CategoryEventViewStore.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 20.10.2025.
//

import Foundation
import ReminderDomainContracts

@MainActor
public final class CategoryEventViewStore: ObservableObject {
  @Published public var eventTitle: String
  @Published public var eventDate: Date
  @Published public var eventComment: String
  @Published public var eventRemindRepeat: RemindRepeatEnum
  
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
  
  @Published public var remindRepeatOptions: [RemindRepeatEnum]
  public var remindRepeatTitles: [RemindRepeatEnum: String]
  
  public var category: ReminderDomainContracts.Category?
  
  public init() {
    self.eventTitle = ""
    self.eventDate = Date()
    self.eventComment = ""
    self.eventRemindRepeat = .everyYear
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
    self.remindRepeatOptions = []
    self.remindRepeatTitles = [:]
    self.category = nil
  }
}
