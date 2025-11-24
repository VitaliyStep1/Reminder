//
//  SharedShadowLightModifier.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct SharedShadowLightModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .shadow(color: SharedColor.Shadow.light, radius: 4, x: 0, y: 3)
  }
}

extension View {
  public func sharedShadowLight() -> some View {
    modifier(SharedShadowLightModifier())
  }
}
