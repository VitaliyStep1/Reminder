//
//  EventDetailsSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventDetailsSectionView: View {
  @ObservedObject private var detailsSectionData: EventDetailsSectionData
  
  init(detailsSectionData: EventDetailsSectionData) {
    self.detailsSectionData = detailsSectionData
  }
  
  var body: some View {
    EventSectionContainer(title: Localize.eventDetailsSectionTitle, systemImageName: "square.and.pencil") {
      EventSubSectionContainer(title: Localize.eventTitleTitle) {
        EventTextField(placeholder: Localize.eventTitlePlaceholder, text: $detailsSectionData.eventTitle)
      }
      sectionDivider
      EventSubSectionContainer(title: Localize.eventCommentTitle) {
        EventTextField(placeholder: Localize.eventCommentPlaceholder, text: $detailsSectionData.eventComment)
      }
      sectionDivider
      EventSubSectionContainer(title: Localize.eventDateTitle) {
        EventDateView(eventDate: $detailsSectionData.eventDate)
          .padding(.horizontal, DSSpacing.s4)
      }
    }
  }
  
  private var sectionDivider: some View {
    Divider()
      .padding(.horizontal, DSSpacing.sMinus8)
  }
}
