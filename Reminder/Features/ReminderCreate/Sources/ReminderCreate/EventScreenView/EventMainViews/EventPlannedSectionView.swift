//
//  EventPlannedSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventPlannedSectionView: View {
  @ObservedObject private var plannedSectionData: EventPlannedSectionData
  
  init(plannedSectionData: EventPlannedSectionData) {
    self.plannedSectionData = plannedSectionData
  }
  
  var body: some View {
    EventSectionContainer(title: Localize.plannedRemindsSectionTitle, systemImageName: "square.and.pencil") {
      switch plannedSectionData.plannedRemindsRepresentationEnum {
      case .noRemindPermission:
        noRemindPermissionView
      case .noPlannedReminds:
        Text(Localize.noPlannedRemindsText)
      case .plannedReminds(let plannedReminds):
        plannedRemindsView(plannedReminds: plannedReminds)
      }
    }
  }
  
  @ViewBuilder
  private var noRemindPermissionView: some View {
    Text(Localize.notificationsNotAllowedText)
    Button {

    } label: {
      Text(Localize.allowNotificationsButton)
    }
    .buttonStyle(DSSecondaryButtonStyle())
  }

  private func plannedRemindsView(plannedReminds: [EventEntity.PlannedRemind]) -> some View {
    Text(Localize.plannedRemindsSectionTitle)
  }
}
