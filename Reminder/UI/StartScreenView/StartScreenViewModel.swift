//
//  StartScreenViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Combine

class StartScreenViewModel: ObservableObject {
  var dataService: DataServiceProtocol?
  
  func setup(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }
  
  func viewTaskCalled() {
    dataService?.setupDataAtStart()
  }
}
