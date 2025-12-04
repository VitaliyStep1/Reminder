//
//  StartCoordinator.swift
//  ReminderStartUI
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderDomainContracts

@MainActor
public final class StartCoordinator: CoordinatorProtocol {
  let splashState = SplashScreenState()

  private let startScreenBuilder: StartScreenBuilder
  private let languageService: LanguageServiceProtocol

  public init(startScreenBuilder: @escaping StartScreenBuilder, languageService: LanguageServiceProtocol) {
    self.startScreenBuilder = startScreenBuilder
    self.languageService = languageService
  }

  public func start() -> AnyView {
    let startView = startScreenBuilder(splashState)
      .environmentObject(splashState)
      .environment(\.locale, languageService.locale)

    return AnyView(startView)
  }
}
