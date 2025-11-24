//
//  SharedMainTextFieldStyle.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 15.11.2025.
//

import SwiftUI

public struct SharedMainTextFieldStyle: TextFieldStyle {
  private let isTextNotEmpty: Bool
  
  public init(isTextNotEmpty: Bool) {
    self.isTextNotEmpty = isTextNotEmpty
  }
  
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(.horizontal, 14)
      .padding(.vertical, 12)
      .background(fieldBackground)
      .overlay(
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .stroke(SharedColor.Accent.primary.opacity(isTextNotEmpty ? 0.4 : 0), lineWidth: 1)
      )
  }
  
  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: 14, style: .continuous)
      .fill(SharedColor.Background.primary.opacity(0.9))
      .sharedShadowLight()
  }
}
