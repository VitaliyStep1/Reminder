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
    self.detailsSectionData = detailsSectionData
  }
  
  var body: some View {
    EventSectionContainer(title: TextEnum.eventDetailsSectionTitle.localized, systemImageName: "square.and.pencil") {
      EventSubSectionContainer(title: TextEnum.eventTitleTitle.localized) {
        EventTextField(placeholder: TextEnum.eventTitlePlaceholder.localized, text: $detailsSectionData.eventTitle)
      }
      sectionDivider
      EventSubSectionContainer(title: TextEnum.eventCommentTitle.localized) {
        EventTextField(placeholder: TextEnum.eventCommentPlaceholder.localized, text: $detailsSectionData.eventComment)
      }
      sectionDivider
      EventSubSectionContainer(title: TextEnum.eventDateTitle.localized) {
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
