//
//  ConfirmationDialogInfo.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

struct ConfirmationDialogInfo {
  let title: String
  let message: String
  var deleteButtonTitle: String = "Delete"
  var deleteButtonHandler: (() -> Void)?
  var cancelButtonTitle: String = "Cancel"
}
