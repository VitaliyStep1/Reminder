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
      if viewModel.createEventViewIsPresented {
        CategoryCreateEventView(title: $viewModel.createEventViewTitle, comment: $viewModel.createEventViewComment, createButtonAction: viewModel.createEventViewCreateButtonTapped)
      }
    }
    .onAppear {
      viewModel.viewAppeared()
    }
    .task {
      viewModel.setup(dataService: appDependencies.dataService)
      viewModel.viewTaskCalled()
    }
    .navigationTitle(viewModel.navigationTitle)
    
  }
}
