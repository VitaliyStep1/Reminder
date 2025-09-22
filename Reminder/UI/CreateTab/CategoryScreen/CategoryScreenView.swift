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
  
  @State var isCreateEventViewVisible = false
  
  var body: some View {
    ZStack {
      VStack {
        List {
          ForEach(viewModel.eventEntities) { eventEntity in
            HStack {
              Text(eventEntity.title)
              Spacer()
              Text(eventEntity.comment ?? "")
            }
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
      if isCreateEventViewVisible {
        CategoryCreateEventView(title: $viewModel.createEventViewTitle, date: $viewModel.createEventViewDate, comment: $viewModel.createEventViewComment, createButtonAction: viewModel.createEventViewCreateButtonTapped, cancelButtonAction: viewModel.createEventViewCancelButtonTapped)
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
    .onReceive(viewModel.showCreateEventViewSubject, perform: {
      withAnimation {
        isCreateEventViewVisible = true
      }
    })
    .onReceive(viewModel.hideCreateEventViewSubject, perform: {
      withAnimation {
        isCreateEventViewVisible = false
      }
    })
    .animation(.easeInOut, value: isCreateEventViewVisible)
    .navigationTitle(viewModel.navigationTitle)
    
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
