//
//  EventPlannedSectionData.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import Foundation

@MainActor
class EventPlannedSectionData: ObservableObject {
  @Published var plannedRemindsRepresentationEnum: EventEntity.PlannedRemindsRepresentationEnum
  
  init(plannedRemindsRepresentationEnum: EventEntity.PlannedRemindsRepresentationEnum) {
    self.plannedRemindsRepresentationEnum = plannedRemindsRepresentationEnum
  }
}
