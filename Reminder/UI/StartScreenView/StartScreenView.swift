//
//  StartScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct StartScreenView: View {
  let viewModel = StartScreenViewModel()
  @EnvironmentObject var appConfiguration: AppConfiguration
  @EnvironmentObject var appDependencies: AppDependencies
  @State var isSplashScreenVisible: Bool = true
  
  var body: some View {
    Group {
      if appConfiguration.isWithSplashScreen && isSplashScreenVisible {
        SplashScreenView(isSplashScreenVisible: $isSplashScreenVisible)
      } else {
        takeMainScreen()
      }
    }
    .task {
      viewModel.setup(dataService: appDependencies.dataService)
      viewModel.viewTaskCalled()
    }
  }
  
  private func takeMainScreen() -> some View {
    MainTabView()
  }
}

#Preview {
  StartScreenPreview()
}

@MainActor
private struct StartScreenPreview: View {
  @StateObject private var appDependenciesLoader = AppDependenciesLoader()
  
  var body: some View {
    Group {
      if let appDependencies = appDependenciesLoader.instance {
        StartScreenView()
          .environmentObject(AppConfiguration.previewAppConfiguration)
          .environmentObject(appDependencies)
      } else {
        ProgressView("Loading appDependencies...")
      }
    }
    .task {
      appDependenciesLoader.instance = await AppDependencies.make(isForPreview: true)
    }
  }
}
