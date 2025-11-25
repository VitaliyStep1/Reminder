//
//  SplashScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDesignSystem

public struct SplashScreenView: View {
  @Binding var isSplashScreenVisible: Bool
  
  public init(isSplashScreenVisible: Binding<Bool>) {
    _isSplashScreenVisible = isSplashScreenVisible
  }
  
  public var body: some View {
    ZStack {
      DSColor.Accent.primary.ignoresSafeArea(edges: .all)
      Text(TextEnum.splashTitle.localized)
        .font(.dsTitleLarge)
        .foregroundStyle(DSColor.Text.inverse)
        .dsShadow(.r14AccentStrong)
    }.task {
      try? await Task.sleep(for: .seconds(2))
      self.isSplashScreenVisible = false
    }
  }
}
