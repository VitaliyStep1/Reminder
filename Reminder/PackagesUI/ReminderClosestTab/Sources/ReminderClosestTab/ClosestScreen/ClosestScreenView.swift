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
    VStack(spacing: 24) {
      Spacer()
      
      Image(systemName: "calendar.badge.plus")
        .font(.system(size: 56))
        .foregroundStyle(ReminderColor.Accent.primary)
      
      Text(noEventsText)
        .font(.body)
        .multilineTextAlignment(.center)
        .foregroundStyle(ReminderColor.Text.secondary)
      
      Spacer()
      createEventButton
    }
    //    .padding(24)
    //    .frame(maxWidth: 320)
    .background(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(ReminderColor.Background.secondary)
    )
    //    .padding(.horizontal, 32)
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
