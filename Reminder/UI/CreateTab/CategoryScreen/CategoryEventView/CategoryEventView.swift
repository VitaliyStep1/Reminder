//
//  CategoryEventView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 13.09.2025.
//

import SwiftUI

struct CategoryEventView: View {
  @StateObject var viewModel: CategoryEventViewModel
  
  var body: some View {
    ZStack {
      Color(.systemBackground)
        .ignoresSafeArea()
      
      VStack(spacing: 16) {
        Text(viewModel.viewTitle)
          .font(.headline)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("Title:")
          TextField("Title", text: $viewModel.title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          
          HStack {
            Spacer()
            DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
              .datePickerStyle(.wheel)
              .labelsHidden()
            Spacer()
          }
          
          Text("Comment:")
          TextField("Comment", text: $viewModel.comment)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        Button(action: {
          viewModel.saveButtonTapped()
        }) {
          Group {
            if viewModel.isSaving {
              ProgressView()
                .tint(.white)
            } else {
              Text(viewModel.saveButtonTitle)
            }
          }
          .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
          .background(Color.blue)
          .foregroundStyle(.white)
          .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(viewModel.isSaving || viewModel.isDeleting)
        
        Button(action: {
          viewModel.cancelButtonTapped()
        }) {
          Text(viewModel.cancelButtonTitle)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.gray)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .disabled(viewModel.isSaving || viewModel.isDeleting)
        
        if viewModel.isDeleteButtonVisible {
          Button(action: {
            viewModel.deleteButtonTapped()
          }) {
            Group {
              if viewModel.isDeleting {
                ProgressView()
                  .tint(.white)
              } else {
                Text(viewModel.deleteButtonTitle)
              }
            }
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color.red)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .disabled(viewModel.isSaving || viewModel.isDeleting)
        }
      }
      .padding()
      .frame(maxWidth: 400)
      .background(Color(UIColor.secondarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(radius: 10)
    }
  }
}

#Preview {
  CategoryEventPreview()
}

@MainActor
private struct CategoryEventPreview: View {
  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
  @State private var categoryId: ObjectId?
  
  var body: some View {
    Group {
      if let appDependencies = appDependenciesLoader.instance {
        if let categoryId {
          let viewModel = CategoryEventViewModel(dataService: appDependencies.dataService, type: .create(categoryId: categoryId), eventsWereChangedHandler: {}, closeViewHandler: {})
          CategoryEventView(viewModel: viewModel)
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
