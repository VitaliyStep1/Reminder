//
//  SharedDeleteConfirmationDialogModifier.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 08.11.2025.
//

import SwiftUI

public struct SharedDeleteConfirmationDialogModifier: ViewModifier {
  @Binding private var isPresented: Bool
  private var title: String
  private var deleteAction: () -> Void
  private var message: String
  
  public init(isPresented: Binding<Bool>, title: String, deleteAction: @escaping () -> Void, message: String) {
    _isPresented = isPresented
    self.title = title
    self.deleteAction = deleteAction
    self.message = message
  }
  
  public func body(content: Content) -> some View {
    content.confirmationDialog(title, isPresented: $isPresented, titleVisibility: .visible) {
      let deleteTitle = TextEnum.delete.localized
      Button(deleteTitle, role: .destructive, action: deleteAction)
      let cancelTitle = TextEnum.cancel.localized
      Button(cancelTitle, role: .cancel, action: {})
    } message: {
      Text(message)
    }
  }
}

public extension View {
  public func sharedDeleteConfirmationDialog(isPresented: Binding<Bool>, title: String, deleteAction: @escaping () -> Void, message: String) -> some View {
    modifier(
      SharedDeleteConfirmationDialogModifier(isPresented: isPresented, title: title, deleteAction: deleteAction, message: message)
    )
  }
}
