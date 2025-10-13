//
//  ViewFactoryKey.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 06.10.2025.
//

import SwiftUI

private struct ViewFactoryKey: @preconcurrency EnvironmentKey {
  @MainActor static let defaultValue: (any ViewFactoryProtocol)? = nil
}

public extension EnvironmentValues {
  var viewFactory: (any ViewFactoryProtocol)? {
    get { self[ViewFactoryKey.self] }
    set { self[ViewFactoryKey.self] = newValue }
  }
}

public extension View {
  func injectViewFactory(_ f: any ViewFactoryProtocol) -> some View { environment(\.viewFactory, f) }
}
