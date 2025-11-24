//
//  SharedAlertModifier.swift
//  ReminderSharedUI
//
//  Created by OpenAI ChatGPT.
//

import SwiftUI

public struct SharedAlertModifier: ViewModifier {
  @Binding private var isPresented: Bool
  private let title: String
  private let message: String
  private let buttonTitle: String
  private let completion: (() -> Void)?

  public init(
    isPresented: Binding<Bool>,
    title: String,
    message: String,
    buttonTitle: String,
    completion: (() -> Void)?
  ) {
    _isPresented = isPresented
    self.title = title
    self.message = message
    self.buttonTitle = buttonTitle
    self.completion = completion
  }

  public func body(content: Content) -> some View {
    content.alert(title, isPresented: $isPresented) {
      Button(buttonTitle, role: .cancel) {
        completion?()
      }
    } message: {
      Text(message)
    }
  }
}

public extension View {
  func sharedAlert(
    isPresented: Binding<Bool>,
    title: String,
    message: String,
    buttonTitle: String,
    completion: (() -> Void)?
  ) -> some View {
    modifier(
      SharedAlertModifier(
        isPresented: isPresented,
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        completion: completion
      )
    )
  }
  
  func sharedErrorAlert(
    isPresented: Binding<Bool>,
    message: String,
    completion: (() -> Void)?
  ) -> some View {
    let title = TextEnum.error.localized
    let buttonTitle = TextEnum.ok.localized
    return sharedAlert(isPresented: isPresented, title: title, message: message, buttonTitle: buttonTitle, completion: completion)
  }
}
