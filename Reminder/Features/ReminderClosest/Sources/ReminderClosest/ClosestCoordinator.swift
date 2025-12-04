//
//  ClosestCoordinator.swift
//  ReminderClosestTab
//
//  Created by OpenAI's ChatGPT.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderMainTabViewContracts

@MainActor
public final class ClosestCoordinator: CoordinatorProtocol {
  private let closestScreenBuilder: ClosestScreenBuilder

  public init(closestScreenBuilder: @escaping ClosestScreenBuilder) {
    self.closestScreenBuilder = closestScreenBuilder
  }

  public func start() -> AnyView {
    let view = closestScreenBuilder()
    return AnyView(view)
  }
}
