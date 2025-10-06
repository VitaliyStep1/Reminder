//
//  StartScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct StartScreenView: View {
  @StateObject var viewModel: StartScreenViewModel
  @EnvironmentObject var splashState: SplashScreenState
  @Environment(\.viewFactory) private var viewFactory
  
  var body: some View {
    Group {
      if splashState.isVisible {
        viewFactory.make(.splash)
      } else {
        takeMainScreen()
      }
    }
    .task {
      viewModel.viewTaskCalled()
    }
  }
  
  private func takeMainScreen() -> some View {
    MainTabView()
  }
}

//#Preview {
//  StartScreenPreview()
//}
//
//@MainActor
//private struct StartScreenPreview: View {
//  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
//  
//  var body: some View {
//    Group {
//      if let appDependencies = appDependenciesLoader.instance {
//        StartScreenView()
//          .environmentObject(AppConfiguration.previewAppConfiguration)
//          .environmentObject(appDependencies)
//      } else {
//        ProgressView("Loading appDependencies...")
//      }
//    }
//    .task {
//      appDependenciesLoader.instance = await AppDependencies.make(isForPreview: true)
//    }
//  }
//}
