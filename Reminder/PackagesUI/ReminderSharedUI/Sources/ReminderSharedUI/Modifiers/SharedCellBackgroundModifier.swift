//
//  SharedCellBackgroundModifier.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct SharedCellBackgroundModifier: ViewModifier {
  public init() {}
  
  public func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(16)
      .background {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(ReminderColor.Background.groupedSecondary)
      }
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
  }
}

extension View {
  public func sharedCellBackground() -> some View {
    modifier(SharedCellBackgroundModifier())
  }
}
