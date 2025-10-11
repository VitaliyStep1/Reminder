//
//  ViewFactoryProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI

public protocol ViewFactoryProtocol: AnyObject {
  func make(_ route: Route) -> AnyView
  
  func makeCategoryEventView(
    categoryEventViewType: CategoryEventViewType,
    eventsWereChangedHandler: @escaping @Sendable () -> Void,
    closeViewHandler: @escaping @Sendable () -> Void
  ) -> AnyView
}
