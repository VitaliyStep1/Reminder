//
//  SharedMainButtonStyle.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct SharedMainButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .background(
        LinearGradient(
          colors: [ReminderColor.Category.gradientStart, ReminderColor.Category.gradientEnd],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .foregroundStyle(ReminderColor.Text.inverse)
      .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
      .shadow(color: ReminderColor.Category.shadow, radius: 10, x: 0, y: 6)
  }
}
