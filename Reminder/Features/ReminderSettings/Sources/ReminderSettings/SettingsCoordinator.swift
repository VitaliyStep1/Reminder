//
//  SettingsCoordinator.swift
//  ReminderSettingsTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderResolver

@MainActor
public final class SettingsCoordinator: CoordinatorProtocol {
  private let resolver: Resolver

  public init(resolver: Resolver) {
    self.resolver = resolver
  }

  public func start() -> AnyView {
    let viewModel = SettingsViewModel(
      takeDefaultRemindTimeDateUseCase: resolver.takeDefaultRemindTimeDateUseCaseProtocol,
      updateDefaultRemindTimeDateUseCase: resolver.updateDefaultRemindTimeDateUseCaseProtocol,
      takeSettingsLanguageUseCase: resolver.takeSettingsLanguageUseCaseProtocol,
      updateSettingsLanguageUseCase: resolver.updateSettingsLanguageUseCaseProtocol
    )
    let view = SettingsScreenView(viewModel: viewModel)
    return AnyView(view)
  }
}
