//
//  BackgroundSharedView.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 30.10.2025.
//

import SwiftUI

public struct BackgroundSharedView: View {

  public init() { }

  public var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [ReminderColor.Background.grouped, ReminderColor.Background.secondary]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea()
  }
}
