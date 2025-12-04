//
//  ReminderApp.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderDesignSystem
import ReminderAppDI
import ReminderDomain

@main
struct ReminderApp: App {
  private let di: AppDI = AppDI.shared
  
  @StateObject var languageService: LanguageService
  
  init() {
    DesignSystemFonts.registerFonts()
    let languageService = di.assembler.resolver.resolve(LanguageService.self)!
    _languageService = StateObject(wrappedValue: languageService)
  }

  var body: some Scene {
    WindowGroup {
      di.makeRootView()
        .environment(\.locale, languageService.locale)
    }
  }
}


