//
//  ClosestScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import SwiftUI
import ReminderSharedUI

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
        .navigationTitle("Closest events")
    }
  }
  
  @ViewBuilder
  var contentView: some View {
    switch viewModel.screenStateEnum {
    case .empty(let title):
      emptyStateView(noEventsText: title)
    case .withData:
      EmptyView()
    }
  }
  
  func emptyStateView(noEventsText: String) -> some View {
    VStack {
      Spacer()
      SharedNoDataView(systemImageName: "calendar.badge.plus", title: noEventsText)
      Spacer()
      createEventButton
    }
  }
  
  var createEventButton: some View {
    Button(action: {
      viewModel.createEventClicked()
    }) {
      Label("Create event", systemImage: "plus.circle.fill")
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
          LinearGradient(
            colors: [ReminderColor.Category.gradientStart, ReminderColor.Category.gradientEnd],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .foregroundStyle(ReminderColor.Text.inverse)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: ReminderColor.Category.shadow, radius: 10, x: 0, y: 6)
    }
  }
}
