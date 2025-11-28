//
//  EventAlertsSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderDesignSystem

struct EventAlertsSectionView: View {
  @ObservedObject private var alertsSectionData: EventAlertsSectionData
  let interactor: EventInteractor
  
  init(alertsSectionData: EventAlertsSectionData, interactor: EventInteractor) {
    self.alertsSectionData = alertsSectionData
    self.interactor = interactor
  }
  
  var body: some View {
    EventSectionContainer(title: Localize.alertsSectionTitle, systemImageName: "bell.badge") {
      EventSubSectionContainer(title: Localize.repeatEveryTitle) {
        repeatContent
      }
      sectionDivider
      remindTimeView
    }
  }
  
  @ViewBuilder
  private var repeatContent: some View {
    switch alertsSectionData.repeatRepresentationEnum {
    case .picker(let values, let titles):
      let titleString = String(localized: Localize.repeatEveryTitle)
      Picker(titleString, selection: $alertsSectionData.remindRepeat) {
        ForEach(values, id: \.self) { option in
          Text(titles[option] ?? "")
            .tag(option)
        }
      }
      .pickerStyle(.segmented)
    case .text(let text):
      Text(text)
        .font(.dsBodyMedium)
        .padding(.horizontal, DSSpacing.s14)
        .padding(.vertical, DSSpacing.s12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(fieldBackground)
    }
  }
  
  @ViewBuilder
  private var remindTimeView: some View {
    VStack(alignment: .leading, spacing: DSSpacing.s12) {
      EventRemindTimeRow(
        title: Localize.remindTime1Title,
        selection: $alertsSectionData.remindTimeDate1
      )
      if alertsSectionData.isRemindTime2ViewVisible {
        EventRemindTimeRow(
          title: Localize.remindTime2Title,
          selection: optionalDateBinding(keyPath: \.remindTimeDate2),
          removeAction: interactor.removeRemindTimeDate2ButtonTapped
        )
      }
      if alertsSectionData.isRemindTime3ViewVisible {
        EventRemindTimeRow(
          title: Localize.remindTime3Title,
          selection: optionalDateBinding(keyPath: \.remindTimeDate3),
          removeAction: interactor.removeRemindTimeDate3ButtonTapped
        )
      }
      if alertsSectionData.isAddRemindTimeButtonVisible {
        EventSecondaryButton(action: interactor.addRemindTimeButtonTapped, title: Localize.addRemindTimeButtonTitle, imageName: "plus.circle.fill")
      }
    }
  }
  
  private func optionalDateBinding(
    keyPath: ReferenceWritableKeyPath<EventAlertsSectionData, Date?>
  ) -> Binding<Date> {
    Binding(
      get: {
        alertsSectionData[keyPath: keyPath] ?? alertsSectionData.defaultRemindTimeDate
      },
      set: { newValue in
        alertsSectionData[keyPath: keyPath] = newValue
      }
    )
  }
  
  private var sectionDivider: some View {
    Divider()
      .padding(.horizontal, DSSpacing.sMinus8)
  }
  
  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: DSRadius.r14, style: .continuous)
      .fill(DSColor.Background.primary.opacity(0.9))
      .dsShadow(.r4Light)
  }
}
