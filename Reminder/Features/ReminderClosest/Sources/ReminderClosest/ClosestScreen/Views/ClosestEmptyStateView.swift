//
//  ClosestEmptyStateView.swift
//  ReminderClosestTab
//
//  Created by Vitaliy Stepanenko on 14.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct ClosestEmptyStateView: View {
  let noEventsText: String
  let createEventButtonAction: () -> Void
  
  init(noEventsText: String, createEventButtonAction: @escaping () -> Void) {
    self.noEventsText = noEventsText
    self.createEventButtonAction = createEventButtonAction
  }
  
  var body: some View {
    VStack {
      Spacer()
      DSNoDataView(systemImageName: "calendar.badge.plus", title: noEventsText)
      Spacer()
      ClosestCreateEventButton(systemImageName: "plus.circle.fill", title: TextEnum.closestCreateEventButtonTitle.localized, action: createEventButtonAction)
    }
  }
}
