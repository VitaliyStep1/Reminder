//
//  EventPlannedSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventPlannedSectionView: View {
  @ObservedObject private var plannedSectionData: EventPlannedSectionData
  
  init(plannedSectionData: EventPlannedSectionData) {
    self.plannedSectionData = plannedSectionData
  }
  
  var body: some View {
    EventSectionContainer(title: "Planned Reminds", systemImageName: "square.and.pencil") {
      switch plannedSectionData.plannedRemindsRepresentationEnum {
      case .noRemindPermission:
        noRemindPermissionView
      case .noPlannedReminds:
        Text("There are no planned reminds yet.")
      case .plannedReminds(let plannedReminds):
        plannedRemindsView(plannedReminds: plannedReminds)
      }
    }
  }
  
  @ViewBuilder
  private var noRemindPermissionView: some View {
    Text("You have not allowed to send notifications yet.")
    Button {
      
    } label: {
      Text("Allow notifications")
    }
  }
  
  private func plannedRemindsView(plannedReminds: [EventEntity.PlannedRemind]) -> some View {
    Text("Planned Reminds")
  }
}
