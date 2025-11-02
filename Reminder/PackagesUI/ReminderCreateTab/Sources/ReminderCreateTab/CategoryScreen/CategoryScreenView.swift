//
//  CategoryScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderSharedUI

public struct CategoryScreenView: View {
  @StateObject var viewModel: CategoryViewModel
  
  @Environment(\.viewFactory) var viewFactory
  
  public init(viewModel: CategoryViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ZStack {
      BackgroundSharedView()
      VStack(spacing: 20) {
        headerView
        contentView
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
  var headerView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewModel.headerTitle)
        .font(.largeTitle.weight(.semibold))
        .foregroundStyle(.primary)
      
      Text(viewModel.headerSubTitle)
        .font(.callout)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  var contentView: some View {
    switch viewModel.screenStateEnum {
    case .empty(let title):
      emptyStateView(title: title)
    case .withEvents(let events):
      withEventsView(events: events)
    }
  }
  
  @ViewBuilder
  func emptyStateView(title: String) -> some View {
    Spacer()
    VStack(spacing: 12) {
      Image(systemName: "calendar.badge.plus")
        .font(.system(size: 42, weight: .medium))
        .foregroundStyle(ReminderColor.Category.icon)
      Text(title)
        .font(.headline)
    }
    .frame(maxWidth: .infinity)
    .padding(32)
    .background {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(ReminderColor.Background.groupedSecondary)
    }
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(color: ReminderColor.Shadow.extraLight, radius: 10, x: 0, y: 6)
    Spacer()
  }
  
  func withEventsView(events: [CategoryEntity.Event]) -> some View {
    ScrollView {
      LazyVStack(spacing: 14) {
        ForEach(events) { event in
          CategoryEventRowView(title: event.title, dateString: event.date, tapAction: {
            viewModel.eventTapped(eventId: event.id)
          })
        }
      }
      .padding(.vertical, 4)
    }
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

