//
//  ClosestCoordinator.swift
//  ReminderClosestTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderResolver

@MainActor
public final class ClosestCoordinator: CoordinatorProtocol {
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
