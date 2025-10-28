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
    }
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.viewTaskCalled()
    }
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .alert(viewModel.alertInfo.title, isPresented: $viewModel.isAlertVisible) {
      Button(viewModel.alertInfo.buttonTitle, role: .cancel) {}
    } message: {
      Text(viewModel.alertInfo.message)
    }
  }
}

