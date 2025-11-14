//
//  SharedDeleteButtonStyle.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct SharedDeleteButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(
        LinearGradient(
          colors: [ReminderColor.Danger.gradientStart, ReminderColor.Danger.gradientEnd],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .foregroundStyle(ReminderColor.Text.inverse)
      .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
      .shadow(color: ReminderColor.Danger.shadow, radius: 10, x: 0, y: 6)
  }
}
