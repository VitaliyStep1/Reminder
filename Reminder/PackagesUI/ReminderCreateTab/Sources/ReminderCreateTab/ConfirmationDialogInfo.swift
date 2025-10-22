//
//  ConfirmationDialogInfo.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

public struct ConfirmationDialogInfo {
  let title: String
  let message: String
  var deleteButtonTitle: String = "Delete"
  var deleteButtonHandler: (() -> Void)?
  var cancelButtonTitle: String = "Cancel"
  
  public init(title: String, message: String) {
    self.title = title
    self.message = message
  }
  
  public init(title: String, message: String, deleteButtonHandler: (() -> Void)?) {
    self.title = title
    self.message = message
    self.deleteButtonHandler = deleteButtonHandler
  }
}
