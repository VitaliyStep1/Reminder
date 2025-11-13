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
    VStack(spacing: 20) {
      headerView
      contentView
      addButton
    }
    .sharedScreenPadding()
    .sharedScreenBackground()
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.viewTaskCalled()
    }
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .sharedErrorAlert(
      isPresented: $viewModel.isAlertVisible,
      message: viewModel.alertInfo.message,
      completion: viewModel.alertInfo.completion
    )
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
    SharedNoDataView(systemImageName: "calendar.badge.plus", title: title)
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

