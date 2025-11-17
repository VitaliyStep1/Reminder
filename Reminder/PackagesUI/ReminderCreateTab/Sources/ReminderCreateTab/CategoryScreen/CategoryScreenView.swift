//
//  CategoryScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import SwiftUI
import ReminderSharedUI

public struct CategoryScreenView: View {
  @StateObject var viewModel: CategoryViewModel

  public init(viewModel: CategoryViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    contentView
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
  @ViewBuilder
  var contentView: some View {
    VStack(spacing: 20) {
      CategoryHeaderView(title: viewModel.headerTitle, subtitle: viewModel.headerSubTitle)
      
      switch viewModel.screenStateEnum {
      case .empty(let title):
        emptyStateView(title: title)
      case .withEvents(let events):
        withEventsView(events: events)
      }
      
      CategoryAddButton(systemImageName: "plus.circle.fill", title: "Add new event", action: viewModel.addButtonTapped)
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
}

