//
//  SharedScreenPaddingModifier.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 13.11.2025.
//

import SwiftUI

public struct SharedScreenPaddingModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .padding(.horizontal, Styles.Padding.ScreenPadding.horizontal)
      .padding(.top, Styles.Padding.ScreenPadding.top)
      .padding(.bottom, Styles.Padding.ScreenPadding.bottom)
  }
}

extension View {
  public func sharedScreenPadding() -> some View {
    modifier(SharedScreenPaddingModifier())
  }
}
