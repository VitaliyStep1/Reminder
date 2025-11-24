//
//  SharedCancelButtonStyle.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct SharedCancelButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(.ultraThinMaterial)
      )
      .foregroundStyle(SharedColor.Text.blue)
      .overlay(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(SharedColor.Text.secondary.opacity(0.2), lineWidth: 1)
      )
  }
}
