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
  private var closestViewModel: ClosestViewModel

  public init(closestViewModel: ClosestViewModel) {
    self.closestViewModel = closestViewModel
  }

  public func start() -> AnyView {
    let view = ClosestScreenView(viewModel: closestViewModel)
    return AnyView(view)
  }
}
