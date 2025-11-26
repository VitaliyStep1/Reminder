//
//  DSCancelButtonStyle.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct DSCancelButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.dsHeadlineLarge)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(.ultraThinMaterial)
      )
      .foregroundStyle(DSColor.Text.blue)
      .overlay(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(DSColor.Text.secondary.opacity(0.2), lineWidth: 1)
      )
  }
}
