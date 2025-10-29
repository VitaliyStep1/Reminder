//
//  CategoryScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import SwiftUI
import ReminderNavigationContracts

public struct CategoryScreenView: View {
  @StateObject var viewModel: CategoryViewModel
  
  @Environment(\.viewFactory) var viewFactory
  
  public init(viewModel: CategoryViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ZStack {
      backgroundGradient
      VStack(spacing: 20) {
        header
        content
        addButton
      }
      .padding(.horizontal, 16)
      .padding(.bottom, 24)
      .padding(.top, 8)
    }
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.viewTaskCalled()
    }
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .alert(viewModel.alertInfo.title, isPresented: $viewModel.isAlertVisible) {
      Button(viewModel.alertInfo.buttonTitle, role: .cancel) {}
    } message: {
      Text(viewModel.alertInfo.message)
    }
  }
}

private extension CategoryScreenView {
  var backgroundGradient: some View {
    LinearGradient(
      gradient: Gradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemBackground)]),
      startPoint: .top,
      endPoint: .bottom
    )
    .ignoresSafeArea()
  }

  var header: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.navigationTitle)
        .font(.largeTitle.weight(.semibold))
        .foregroundStyle(.primary)

      Text("\(viewModel.entityEvents.count) added event\(viewModel.entityEvents.count == 1 ? "" : "s")")
        .font(.callout)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  var content: some View {
    if viewModel.entityEvents.isEmpty {
      emptyState
    } else {
      ScrollView {
        LazyVStack(spacing: 14) {
          ForEach(viewModel.entityEvents) { eventEntity in
            Button {
              viewModel.eventTapped(eventId: eventEntity.id)
            } label: {
              CategoryEventCellView(
                title: eventEntity.title,
                dateString: eventEntity.date,
                comment: eventEntity.comment
              )
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(16)
              .background(cardBackground)
              .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
          }
        }
        .padding(.vertical, 4)
      }
    }
  }

  var cardBackground: some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
      .fill(Color(.secondarySystemGroupedBackground))
  }

  var emptyState: some View {
    VStack(spacing: 12) {
      Image(systemName: "calendar.badge.plus")
        .font(.system(size: 42, weight: .medium))
        .foregroundStyle(Color.blue)
      Text("No events yet")
        .font(.headline)
      Text("Start by adding your first reminder to keep track of upcoming events.")
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity)
    .padding(32)
    .background(cardBackground)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
  }

  var addButton: some View {
    Button(action: {
      viewModel.addButtonTapped()
    }) {
      Label("Add new event", systemImage: "plus.circle.fill")
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
          LinearGradient(
            colors: [Color.blue, Color.indigo],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 6)
    }
  }
}

