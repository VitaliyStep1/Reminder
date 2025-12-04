//
//  SettingsScreenView.swift
//  ReminderSettingsTab
//
//  Created by Vitaliy Stepanenko on 24.10.2025.
//

import SwiftUI
import ReminderDesignSystem

public struct SettingsScreenView: View {
  @StateObject var viewModel: SettingsViewModel
  
  public init(viewModel: SettingsViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack {
      contentView
        .dsScreenPadding()
        .dsScreenBackground()
        .navigationTitle(Text(Localize.settingsTitle))
    }
  }
  
  var contentView: some View {
    ScrollView {
      VStack {
        dateOptionView
        languageOptionView(languageOptionViewStore: viewModel.languageOptionViewStore)
        Spacer()
      }
    }
  }
  
  var dateOptionView: some View {
    VStack {
      VStack {
        DatePicker(
          selection: $viewModel.defaultRemindTimeDate,
          displayedComponents: .hourAndMinute
        ) {
          Text(Localize.defaultRemindTimeLabel)
        }
        .datePickerStyle(.compact)
        .dsCellBackground()
        .dsShadow(.r6Light)
        HStack {
          Text(Localize.defaultRemindTimeDescription)
            .padding(.horizontal, DSSpacing.s16)
          Spacer()
        }
      }
      Spacer()
    }
  }
  
  func languageOptionView(@Bindable languageOptionViewStore: SettingsLanguageOptionViewStore) -> some View {
    HStack {
      Text(Localize.language_column)
      Spacer()
      Picker(selection: $languageOptionViewStore.selectedLanguage) {
        ForEach(languageOptionViewStore.languages) { language in
          Text(language.title).tag(language)
        }
      } label: {
        Text(Localize.language)
      }
      .pickerStyle(.menu)
      .onChange(of: languageOptionViewStore.selectedLanguage) { selectedLanguage in
        languageOptionViewStore.selectedLanguageChangedHandler(selectedLanguage)
      }
    }
    .dsCellBackground()
    .dsShadow(.r4Heavy)
  }
}
