//
//  DSShadowModifier.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI

public struct DSShadowModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    content
      .shadow(color: DSColor.Shadow.heavy, radius: 4, x: 0, y: 3)
  }
}

extension View {
  public func dsShadow() -> some View {
    modifier(DSShadowModifier())
  }
}
