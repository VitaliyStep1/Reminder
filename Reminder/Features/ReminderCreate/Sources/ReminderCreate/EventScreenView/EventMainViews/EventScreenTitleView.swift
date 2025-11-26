//
//  EventScreenTitleView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 09.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventScreenTitleView: View {
  @ObservedObject private var screenTitleData: EventScreenTitleData
  
  init(screenTitleData: EventScreenTitleData) {
    self.screenTitleData = screenTitleData
  }
  
  var body: some View {
    Label {
      Text(screenTitleData.screenTitle)
        .font(.largeTitle.bold())
    } icon: {
      Image(systemName: "calendar.badge.plus")
        .font(.title3.weight(.semibold))
        .foregroundStyle(DSColor.Text.inverse)
        .padding(12)
        .background(
          Circle()
            .fill(
              LinearGradient(
                colors: [DSColor.Accent.gradientStart, DSColor.Accent.gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
        )
        .dsShadow()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
