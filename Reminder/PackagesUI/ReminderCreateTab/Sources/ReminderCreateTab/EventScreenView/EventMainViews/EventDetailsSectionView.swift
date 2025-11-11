//
//  EventDetailsSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventDetailsSectionView: View {
  @ObservedObject private var detailsSectionData: EventDetailsSectionData
  
  init(detailsSectionData: EventDetailsSectionData) {
    _detailsSectionData = ObservedObject(wrappedValue: detailsSectionData)
  }
  
  var body: some View {
    EventSectionContainer(title: "Event details", systemImageName: "square.and.pencil") {
      EventSubSectionContainer(title: "Title") {
        EventTextField(placeholder: "Title", text: $detailsSectionData.eventTitle)
      }
      sectionDivider
      EventSubSectionContainer(title: "Comment") {
        EventTextField(placeholder: "Comment", text: $detailsSectionData.eventComment)
      }
      sectionDivider
      EventSubSectionContainer(title: "Date") {
        EventDateView(eventDate: $detailsSectionData.eventDate)
          .padding(.horizontal, 4)
      }
    }
  }
  
  private var sectionDivider: some View {
    Divider()
      .padding(.horizontal, -8)
  }
}
