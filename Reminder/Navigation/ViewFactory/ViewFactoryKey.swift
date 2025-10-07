//
//  ViewFactoryKey.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 06.10.2025.
//

import SwiftUI

private struct ViewFactoryKey: EnvironmentKey {
  static let defaultValue: ViewFactory = ViewFactory(resolver: DIService().resolver)
}

extension EnvironmentValues {
  var viewFactory: ViewFactory {
    get { self[ViewFactoryKey.self] }
    set { self[ViewFactoryKey.self] = newValue }
  }
}
