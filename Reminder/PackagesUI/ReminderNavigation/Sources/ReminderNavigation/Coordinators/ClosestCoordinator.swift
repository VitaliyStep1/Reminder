//
//  ClosestCoordinator.swift
//  ReminderNavigation
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderClosestTab
import ReminderResolver

@MainActor
public final class ClosestCoordinator: ClosestCoordinatorProtocol {
  private let resolver: Resolver

  public init(resolver: Resolver) {
    self.resolver = resolver
  }

  public func start() -> AnyView {
    let viewModel = ClosestViewModel(mainTabViewSelectionState: resolver.mainTabViewSelectionState)
    let view = ClosestScreenView(viewModel: viewModel)
    return AnyView(view)
  }
}
