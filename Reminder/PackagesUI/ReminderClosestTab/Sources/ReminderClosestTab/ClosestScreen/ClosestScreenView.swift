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
          ScrollView {
            LazyVStack(spacing: 16) {
              ForEach(viewModel.closestMonthEntities) { entity in
                monthCard(for: entity)
              }
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
          }
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

  func monthCard(for entity: ClosestMonthEntity) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 4) {
          Text(entity.title)
            .font(.headline)

          Text(entity.eventsAmount)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }

        Spacer()

        Image(systemName: "chevron.right")
          .font(.headline.weight(.semibold))
          .foregroundColor(Color(.tertiaryLabel))
      }

      ProgressView(value: min(max(progressValue(for: entity), 0), 1))
        .tint(.accentColor)
    }
    .padding(20)
    .background(
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .fill(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.05), radius: 12, y: 6)
    )
  }

  func progressValue(for entity: ClosestMonthEntity) -> Double {
    guard let value = Double(entity.eventsAmount.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
      return 0
    }

    return value / 10
  }
}
