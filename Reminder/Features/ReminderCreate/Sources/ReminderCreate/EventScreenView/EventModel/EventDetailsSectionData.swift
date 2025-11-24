//
//  EventDetailsSectionData.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import Foundation

@MainActor
class EventDetailsSectionData: ObservableObject {
  @Published var eventTitle: String
  @Published var eventComment: String
  @Published var eventDate: Date
  
  init(eventTitle: String, eventComment: String, eventDate: Date) {
    self.eventTitle = eventTitle
    self.eventComment = eventComment
    self.eventDate = eventDate
  }
}
