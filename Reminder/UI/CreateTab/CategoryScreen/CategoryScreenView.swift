//
//  CategoryScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import SwiftUI

struct CategoryScreenView: View {
  @EnvironmentObject var appDependencies: AppDependencies
  @StateObject var viewModel: CategoryViewModel
  
  @State var eventViewType: CategoryEventViewType = .notVisible
  
  var body: some View {
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
        let categoryEventViewModel = CategoryEventViewModel(dataService: appDependencies.dataService, type: eventViewType, eventsWereChangedHandler: viewModel.categoryEventWasUpdated,closeViewHandler: viewModel.closeViewWasCalled)
        CategoryEventView(viewModel: categoryEventViewModel)
          .transition(.opacity)
          .zIndex(1)
      }
    }
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.setup(dataService: appDependencies.dataService)
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
    
  }
}

#Preview {
  CategoryScreenPreview()
}

@MainActor
private struct CategoryScreenPreview: View {
  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
  @State private var categoryId: ObjectId?
  
  var body: some View {
    Group {
      if let appDependencies = appDependenciesLoader.instance {
        if let id = categoryId {
          CategoryScreenView(viewModel: .init(categoryId: id))
            .environmentObject(appDependencies)
        } else {
          Text("No category to preview")
        }
      } else {
        ProgressView("Loading appDependencies...")
      }
    }
    .task {
      appDependenciesLoader.instance = await AppDependencies.make(isForPreview: true)
      if let appDependencies = appDependenciesLoader.instance {
        categoryId = try? await appDependencies.previewDataService?.takeFirstCategoryObjectId()
      }
    }
  }
}
