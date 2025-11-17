//
//  CoordinatorProtocol.swift
//  ReminderNavigationContracts
//
//  Created by Vitaliy Stepanenko on 16.11.2025.
//

import SwiftUI

@MainActor
public protocol CoordinatorProtocol {
  func start() -> AnyView
  
}
