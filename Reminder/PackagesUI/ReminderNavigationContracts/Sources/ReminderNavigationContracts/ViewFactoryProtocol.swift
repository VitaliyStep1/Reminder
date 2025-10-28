//
//  ViewFactoryProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI
import ReminderDomainContracts

public protocol ViewFactoryProtocol: AnyObject {
  func make(_ route: Route) -> AnyView
  
  func makeEventScreenView(
    eventScreenViewType: EventScreenViewType,
    eventsWereChangedHandler: @escaping @Sendable (Identifier?) -> Void,
    closeViewHandler: @escaping @Sendable () -> Void
  ) -> AnyView
}
