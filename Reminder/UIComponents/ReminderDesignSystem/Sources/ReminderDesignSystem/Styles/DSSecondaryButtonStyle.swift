//
//  DSSecondaryButtonStyle.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 15.11.2025.
//

import SwiftUI

public struct DSSecondaryButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.dsBodySemibold)
      .padding(.horizontal, DSSpacing.s16)
      .padding(.vertical, DSSpacing.s10)
      .background(
        RoundedRectangle(cornerRadius: DSRadius.r14, style: .continuous)
          .fill(DSColor.Background.primary)
      )
      .overlay(
        RoundedRectangle(cornerRadius: DSRadius.r14, style: .continuous)
          .stroke(DSColor.Accent.primary, lineWidth: 1)
      )
      .foregroundStyle(DSColor.Accent.primary)
      .dsShadow()
      .opacity(configuration.isPressed ? 0.8 : 1)
      .scaleEffect(configuration.isPressed ? 0.97 : 1)
  }
}
