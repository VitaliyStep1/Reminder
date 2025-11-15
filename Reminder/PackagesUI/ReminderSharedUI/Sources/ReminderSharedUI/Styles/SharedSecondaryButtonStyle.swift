//
//  SharedSecondaryButtonStyle.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 15.11.2025.
//

import SwiftUI

public struct SharedSecondaryButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.body.weight(.semibold))
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .fill(SharedColor.Background.primary)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .stroke(SharedColor.Accent.primary, lineWidth: 1)
      )
      .foregroundStyle(SharedColor.Accent.primary)
      .sharedShadow()
      .opacity(configuration.isPressed ? 0.8 : 1)
      .scaleEffect(configuration.isPressed ? 0.97 : 1)
  }
}
