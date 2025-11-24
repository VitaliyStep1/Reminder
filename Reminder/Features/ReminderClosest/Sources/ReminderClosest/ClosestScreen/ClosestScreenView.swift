//
//  ClosestScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import SwiftUI
import ReminderDesignSystem

public struct ClosestScreenView: View {
  @StateObject var viewModel: ClosestViewModel
  
  public init(viewModel: ClosestViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    NavigationStack {
      contentView
        .sharedScreenPadding()
        .sharedScreenBackground()
        .navigationTitle(TextEnum.closestScreenTitle.localized)
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
