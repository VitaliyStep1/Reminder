//
//  ClosestCoordinator.swift
//  ReminderClosestTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import Swinject
import ReminderNavigationContracts
import ReminderMainTabViewContracts
import ReminderResolver

@MainActor
public final class ClosestCoordinator: CoordinatorProtocol {
  private var mainTabViewSelectionState: MainTabViewSelectionState

  public init(mainTabViewSelectionState: MainTabViewSelectionState) {
    self.mainTabViewSelectionState = mainTabViewSelectionState
  }

  public func start() -> AnyView {
    let viewModel = ClosestViewModel(mainTabViewSelectionState: mainTabViewSelectionState)
    let view = ClosestScreenView(viewModel: viewModel)
    return AnyView(view)
  }
}
