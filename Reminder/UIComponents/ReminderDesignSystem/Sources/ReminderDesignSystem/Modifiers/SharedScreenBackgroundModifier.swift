//
//  SharedScreenBackgroundModifier.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 13.11.2025.
//

import SwiftUI

public struct SharedScreenBackgroundModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .background {
        LinearGradient(
          gradient: Gradient(colors: [SharedColor.Background.grouped, SharedColor.Background.secondary]),
          startPoint: .top,
          endPoint: .bottom
        )
        .ignoresSafeArea()
      }
  }
}

extension View {
  public func sharedScreenBackground() -> some View {
    modifier(SharedScreenBackgroundModifier())
  }
}
