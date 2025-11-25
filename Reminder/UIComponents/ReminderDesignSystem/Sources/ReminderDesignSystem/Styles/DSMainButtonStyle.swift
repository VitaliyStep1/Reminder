//
//  DSMainButtonStyle.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct DSMainButtonStyle: ButtonStyle {
  public init() {}
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.dsHeadlineLarge)
      .frame(maxWidth: .infinity)
      .padding(.vertical, DSSpacing.s14)
      .background(
        LinearGradient(
          colors: [DSColor.Category.gradientStart, DSColor.Category.gradientEnd],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .foregroundStyle(DSColor.Text.inverse)
      .clipShape(RoundedRectangle(cornerRadius: DSRadius.r14, style: .continuous))
      .shadow(color: DSColor.Category.shadow, radius: 10, x: 0, y: 6)
  }
}
