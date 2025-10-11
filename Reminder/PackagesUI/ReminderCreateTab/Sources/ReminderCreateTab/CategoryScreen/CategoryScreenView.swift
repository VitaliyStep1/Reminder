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
  
  @State var eventViewType: CategoryEventViewType = .notVisible
  
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
      if eventViewType != .notVisible {
        if let viewFactory {
          viewFactory.makeCategoryEventView(
            categoryEventViewType: eventViewType,
            eventsWereChangedHandler: {
              Task { @MainActor in
                viewModel.categoryEventWasUpdated()
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
        eventViewType = type
      }
    })
    .animation(.easeInOut, value: (eventViewType != .notVisible))
    .navigationTitle(viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.large)
    .alert(viewModel.alertInfo.title, isPresented: $viewModel.isAlertVisible) {
      Button(viewModel.alertInfo.buttonTitle, role: .cancel) {}
    } message: {
      Text(viewModel.alertInfo.message)
    }
  }
}

//#Preview {
//  CategoryScreenPreview()
//}
//
//@MainActor
//private struct CategoryScreenPreview: View {
//  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
//  @State private var categoryId: ObjectId?
//  
//  var body: some View {
//    Group {
//      if let appDependencies = appDependenciesLoader.instance {
//        if let id = categoryId {
//          CategoryScreenView(viewModel: .init(categoryId: id))
//            .environmentObject(appDependencies)
//        } else {
//          Text("No category to preview")
//        }
//      } else {
//        ProgressView("Loading appDependencies...")
//      }
//    }
//    .task {
//      appDependenciesLoader.instance = await AppDependencies.make(isForPreview: true)
//      if let appDependencies = appDependenciesLoader.instance {
//        categoryId = try? await appDependencies.previewDataService?.takeFirstCategoryObjectId()
//      }
//    }
//  }
//}
