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
    EventSectionContainer(title: TextEnum.plannedRemindsSectionTitle.localized, systemImageName: "square.and.pencil") {
      switch plannedSectionData.plannedRemindsRepresentationEnum {
      case .noRemindPermission:
        noRemindPermissionView
      case .noPlannedReminds:
        Text(TextEnum.noPlannedRemindsText.localized)
      case .plannedReminds(let plannedReminds):
        plannedRemindsView(plannedReminds: plannedReminds)
      }
    }
  }
  
  @ViewBuilder
  private var noRemindPermissionView: some View {
    Text(TextEnum.notificationsNotAllowedText.localized)
    Button {

    } label: {
      Text(TextEnum.allowNotificationsButton.localized)
    }
    .buttonStyle(DSSecondaryButtonStyle())
  }

  private func plannedRemindsView(plannedReminds: [EventEntity.PlannedRemind]) -> some View {
    Text(TextEnum.plannedRemindsSectionTitle.localized)
  }
}
