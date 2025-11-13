//
//  SharedScreenBackgroundModifier.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 13.11.2025.
//

import SwiftUI

public struct SharedScreenBackgroundModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .background {
        LinearGradient(
          gradient: Gradient(colors: [ReminderColor.Background.grouped, ReminderColor.Background.secondary]),
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
