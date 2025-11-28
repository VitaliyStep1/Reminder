//
//  CategoryScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import SwiftUI
import ReminderDesignSystem

public struct CategoryScreenView: View {
  @StateObject var viewModel: CategoryViewModel

  public init(viewModel: CategoryViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    contentView
    .dsScreenPadding()
    .dsScreenBackground()
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.viewTaskCalled()
    }
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .dsErrorAlert(
      isPresented: $viewModel.isAlertVisible,
      message: viewModel.alertInfo.message,
      completion: viewModel.alertInfo.completion
    )
  }
}

private extension CategoryScreenView {
  @ViewBuilder
  var contentView: some View {
    VStack(spacing: DSSpacing.s20) {
      CategoryHeaderView(title: viewModel.headerTitle, subtitle: viewModel.headerSubTitle)
      
      switch viewModel.screenStateEnum {
      case .empty(let title):
        emptyStateView(title: title)
      case .withEvents(let events):
        withEventsView(events: events)
      }
      
      CategoryAddButton(systemImageName: "plus.circle.fill", title: Localize.addNewEventButtonTitle, action: viewModel.addButtonTapped)
    }
  }
  
  @ViewBuilder
  func emptyStateView(title: LocalizedStringResource) -> some View {
    Spacer()
    DSNoDataView(systemImageName: "calendar.badge.plus", title: title)
    Spacer()
  }
  
  func withEventsView(events: [CategoryEntity.Event]) -> some View {
    ScrollView {
      LazyVStack(spacing: DSSpacing.s14) {
        ForEach(events) { event in
          CategoryEventRowView(title: event.title, dateString: event.date, tapAction: {
            viewModel.eventTapped(eventId: event.id)
          })
        }
      }
      .padding(.vertical, DSSpacing.s4)
    }
  }
}

