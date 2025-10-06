//
//  CategoriesScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct CategoriesScreenView: View {
  @StateObject var viewModel: CategoriesViewModel
  @Environment(\.viewFactory) var viewFactory
  
  var body: some View {
    NavigationStack(path: $viewModel.path) {
      List {
        ForEach(viewModel.categoryEntities) { categoryEntity in
          Button {
            viewModel.categoryButtonClicked(categoryEntity)
          } label: {
            HStack {
              Text(categoryEntity.title)
              Spacer()
              Text(categoryEntity.eventsAmount)
            }
          }
        }
      }
      .task {
        viewModel.taskWasCalled()
      }
      .navigationTitle(viewModel.navigationTitle)
      .navigationDestination(for: CategoriesCategoryEntity.self) { categoryEntity in
        viewFactory.make(.category(categoryEntity.id))
      }
    }
  }
}

//#Preview {
//  CategoriesScreenPreview()
//}
//
//@MainActor
//private struct CategoriesScreenPreview: View {
//  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
//  
//  var body: some View {
//    Group {
//      if let appDependencies = appDependenciesLoader.instance {
//        CategoriesScreenView(viewModel: CategoriesViewModel())
////          .environmentObject(AppConfiguration.previewAppConfiguration)
////          .environmentObject(appDependencies)
//      } else {
//        ProgressView("Loading appDependencies...")
//      }
//    }
//    .task {
//      appDependenciesLoader.instance = await AppDependencies.make(isForPreview: true)
//    }
//  }
//}
