//
//  StartScreenViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine
import ReminderConfigurations
import ReminderDomainContracts

@MainActor
public class StartScreenViewModel: ObservableObject {
  let appConfiguration: AppConfigurationProtocol
  let setupInitialDataUseCase: SetupInitialDataUseCaseProtocol

  public init(
    appConfiguration: AppConfigurationProtocol,
    setupInitialDataUseCase: SetupInitialDataUseCaseProtocol
  ) {
    self.appConfiguration = appConfiguration
    self.setupInitialDataUseCase = setupInitialDataUseCase
  }

  func viewTaskCalled() async {
    await setupInitialDataUseCase.execute()
  }
}
