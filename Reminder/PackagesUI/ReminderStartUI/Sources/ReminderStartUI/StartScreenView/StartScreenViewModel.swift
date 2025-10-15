//
//  StartScreenViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine
import ReminderDomainContracts
import ReminderConfigurations

@MainActor
public class StartScreenViewModel: ObservableObject {
  let appConfiguration: AppConfigurationProtocol?
  let dataService: DataServiceProtocol
  
  public init(appConfiguration: AppConfigurationProtocol?, dataService: DataServiceProtocol) {
    self.appConfiguration = appConfiguration
    self.dataService = dataService
  }
  
  func viewTaskCalled() async {
    await dataService.setupDataAtStart()
  }
}
