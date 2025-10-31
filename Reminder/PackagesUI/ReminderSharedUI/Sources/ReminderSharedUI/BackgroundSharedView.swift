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
      gradient: Gradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemBackground)]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea()
  }
}
