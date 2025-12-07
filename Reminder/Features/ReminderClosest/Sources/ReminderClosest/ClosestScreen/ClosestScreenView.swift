//
//  ClosestScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import SwiftUI
import ReminderDesignSystem
import Language

public struct ClosestScreenView: View {
  @StateObject var viewModel: ClosestViewModel
  @Environment(\.locale) private var locale
  
  public init(viewModel: ClosestViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    return NavigationStack {
      contentView
        .dsScreenPadding()
        .dsScreenBackground()
        .navigationTitle(
          String(localized: Localize.closestScreenTitle.localed(locale))
        )
    }
  }
  
  @ViewBuilder
  var contentView: some View {
    switch viewModel.screenStateEnum {
    case .empty(let title):
      ClosestEmptyStateView(noEventsText: title, createEventButtonAction: viewModel.createEventClicked)
    case .withData:
      EmptyView()
    }
  }
}
