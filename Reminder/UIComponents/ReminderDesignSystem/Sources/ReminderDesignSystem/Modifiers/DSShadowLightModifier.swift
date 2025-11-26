//
//  DSShadowLightModifier.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct DSShadowLightModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .shadow(color: DSColor.Shadow.light, radius: 4, x: 0, y: 3)
  }
}

extension View {
  public func dsShadowLight() -> some View {
    modifier(DSShadowLightModifier())
  }
}
