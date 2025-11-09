//
//  EventScreenTitleView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventScreenTitleView: View {
  let title: String
  
  var body: some View {
    Label {
      Text(title)
        .font(.largeTitle.bold())
    } icon: {
      Image(systemName: "calendar.badge.plus")
        .font(.title3.weight(.semibold))
        .foregroundStyle(ReminderColor.Text.inverse)
        .padding(12)
        .background(
          Circle()
            .fill(
              LinearGradient(
                colors: [ReminderColor.Accent.gradientStart, ReminderColor.Accent.gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
        )
        .shadow(color: ReminderColor.Accent.shadow, radius: 10, x: 0, y: 6)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
