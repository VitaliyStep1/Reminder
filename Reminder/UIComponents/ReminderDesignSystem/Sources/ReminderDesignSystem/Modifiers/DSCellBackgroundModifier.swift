//
//  DSCellBackgroundModifier.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct DSCellBackgroundModifier: ViewModifier {
  public init() {}
  
  public func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(DSSpacing.s16)
      .background {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(DSColor.Background.groupedSecondary)
      }
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
  }
}

extension View {
  public func dsCellBackground() -> some View {
    modifier(DSCellBackgroundModifier())
  }
}
