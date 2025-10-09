//
//  StartScreenViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine
import ReminderDomain

class StartScreenViewModel: ObservableObject {
  let appConfiguration: AppConfigurationProtocol?
  let dataService: DataServiceProtocol?
  
  init(appConfiguration: AppConfigurationProtocol?, dataService: DataServiceProtocol?) {
    self.appConfiguration = appConfiguration
    self.dataService = dataService
  }
  
  func viewTaskCalled() {
    Task {
      await dataService?.setupDataAtStart()
    }
  }
}
