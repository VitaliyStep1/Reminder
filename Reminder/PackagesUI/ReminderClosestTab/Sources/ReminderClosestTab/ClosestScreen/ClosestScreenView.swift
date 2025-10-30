//
//  ClosestScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import SwiftUI

public struct ClosestScreenView: View {
  @StateObject var viewModel: ClosestViewModel
  
  public init(viewModel: ClosestViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    NavigationStack {
      ZStack {
        Color(.systemGroupedBackground)
          .ignoresSafeArea()

        if viewModel.closestMonthEntities.isEmpty,
           let noEventsText = viewModel.noEventsText {
          emptyStateView(noEventsText: noEventsText)
        } else {
          EmptyView()
        }
      }
      .navigationTitle("Closest events")
    }
  }
}

private extension ClosestScreenView {
  func emptyStateView(noEventsText: String) -> some View {
    VStack(spacing: 24) {
      Image(systemName: "calendar.badge.plus")
        .font(.system(size: 56))
        .foregroundColor(.accentColor)

      Text(noEventsText)
        .font(.body)
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)

      Button {
        viewModel.createEventClicked()
      } label: {
        Text("Create event")
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
    }
    .padding(24)
    .frame(maxWidth: 320)
    .background(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(Color(.secondarySystemBackground))
    )
    .padding(.horizontal, 32)
  }
}
