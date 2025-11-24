//
//  StartScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
public struct StartScreenView: View {
  public typealias ViewBuilder = @MainActor () -> AnyView

  @StateObject var viewModel: StartScreenViewModel
  @EnvironmentObject var splashState: SplashScreenState
  private let splashViewBuilder: ViewBuilder
  private let mainViewBuilder: ViewBuilder

  public init(
    viewModel: StartScreenViewModel,
    splashViewBuilder: @escaping ViewBuilder,
    mainViewBuilder: @escaping ViewBuilder
  ) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.splashViewBuilder = splashViewBuilder
    self.mainViewBuilder = mainViewBuilder
  }

  public var body: some View {
    Group {
      if splashState.isVisible {
        splashViewBuilder()
      } else {
        mainViewBuilder()
      }
    }
    .task {
      let viewModel = self.viewModel
      await viewModel.viewTaskCalled()
    }
  }
}

