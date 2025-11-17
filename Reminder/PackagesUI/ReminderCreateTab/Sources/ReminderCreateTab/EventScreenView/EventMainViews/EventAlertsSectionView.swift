//
//  EventAlertsSectionView.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI
import ReminderSharedUI

struct EventAlertsSectionView: View {
  @ObservedObject private var alertsSectionData: EventAlertsSectionData
  let interactor: EventInteractor
  
  init(alertsSectionData: EventAlertsSectionData, interactor: EventInteractor) {
    self.alertsSectionData = alertsSectionData
    self.interactor = interactor
  }
  
  var body: some View {
    EventSectionContainer(title: TextEnum.alertsSectionTitle.localized, systemImageName: "bell.badge") {
      EventSubSectionContainer(title: TextEnum.repeatEveryTitle.localized) {
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
      Picker(TextEnum.repeatEveryTitle.localized, selection: $alertsSectionData.remindRepeat) {
        ForEach(values, id: \.self) { option in
          Text(titles[option] ?? "")
            .tag(option)
        }
      }
      .pickerStyle(.segmented)
    case .text(let text):
      Text(text)
        .font(.body.weight(.medium))
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(fieldBackground)
    }
  }
  
  @ViewBuilder
  private var remindTimeView: some View {
    VStack(alignment: .leading, spacing: 12) {
      EventRemindTimeRow(
        title: TextEnum.remindTime1Title.localized,
        selection: $alertsSectionData.remindTimeDate1
      )
      if alertsSectionData.isRemindTime2ViewVisible {
        EventRemindTimeRow(
          title: TextEnum.remindTime2Title.localized,
          selection: optionalDateBinding(keyPath: \.remindTimeDate2),
          removeAction: interactor.removeRemindTimeDate2ButtonTapped
        )
      }
      if alertsSectionData.isRemindTime3ViewVisible {
        EventRemindTimeRow(
          title: TextEnum.remindTime3Title.localized,
          selection: optionalDateBinding(keyPath: \.remindTimeDate3),
          removeAction: interactor.removeRemindTimeDate3ButtonTapped
        )
      }
      if alertsSectionData.isAddRemindTimeButtonVisible {
        EventSecondaryButton(action: interactor.addRemindTimeButtonTapped, title: TextEnum.addRemindTimeButtonTitle.localized, imageName: "plus.circle.fill")
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
      .padding(.horizontal, -8)
  }
  
  private var fieldBackground: some View {
    RoundedRectangle(cornerRadius: 14, style: .continuous)
      .fill(SharedColor.Background.primary.opacity(0.9))
      .sharedShadowLight()
  }
}
