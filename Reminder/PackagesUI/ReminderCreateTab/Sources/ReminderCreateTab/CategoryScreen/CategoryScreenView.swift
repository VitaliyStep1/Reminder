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
  
  @State var eventScreenViewType: EventScreenViewType = .notVisible
  
  @Environment(\.viewFactory) var viewFactory
  
  public init(viewModel: CategoryViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ZStack {
      VStack {
        List {
          ForEach(viewModel.entityEvents) { eventEntity in
            Button {
              viewModel.eventTapped(eventId: eventEntity.id)
            } label: {
              CategoryEventCellView(title: eventEntity.title, dateString: eventEntity.date, comment: eventEntity.comment)
                .padding(.vertical, 4)
            }
            .buttonStyle(.plain)
            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
          }
        }
        Spacer()
        Button(action: {
          viewModel.addButtonTapped()
        }) {
          Text("Add new event")
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        
      }
      if eventScreenViewType != .notVisible {
        if let viewFactory {
          viewFactory.makeEventScreenView(
            eventScreenViewType: eventScreenViewType,
            eventsWereChangedHandler: { newCategoryId in
              Task { @MainActor in
                viewModel.categoryEventWasUpdated(newCategoryId: newCategoryId)
              }
            },
            closeViewHandler: {
              Task { @MainActor in
                viewModel.closeViewWasCalled()
              }
            }
          )
          .transition(.opacity)
          .zIndex(1)
        }
      }
    }
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.viewTaskCalled()
    }
    .onReceive(viewModel.eventViewSubject, perform: { type in
      withAnimation {
        eventScreenViewType = type
      }
    })
    .animation(.easeInOut, value: (eventScreenViewType != .notVisible))
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .alert(viewModel.alertInfo.title, isPresented: $viewModel.isAlertVisible) {
      Button(viewModel.alertInfo.buttonTitle, role: .cancel) {}
    } message: {
      Text(viewModel.alertInfo.message)
    }
  }
}

