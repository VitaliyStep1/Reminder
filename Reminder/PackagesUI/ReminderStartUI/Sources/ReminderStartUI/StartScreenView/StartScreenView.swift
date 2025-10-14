//
//  StartScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts

public struct StartScreenView: View {
  @StateObject var viewModel: StartScreenViewModel
  @EnvironmentObject var splashState: SplashScreenState
  @Environment(\.viewFactory) private var viewFactory
  
  public init(viewModel: StartScreenViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    Group {
      if let viewFactory {
        if splashState.isVisible {
          viewFactory.make(.splash)
        } else {
          viewFactory.make(.mainTabView)
        }
      } else {
        EmptyView()
      }
    }
    .task {
      let viewModel = self.viewModel
      await viewModel.viewTaskCalled()
    }
  }
}

