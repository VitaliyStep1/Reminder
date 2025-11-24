//
//  EventScreenTitleData.swift
//  ReminderCreateTab
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import Foundation

@MainActor
class EventScreenTitleData: ObservableObject {
  @Published var screenTitle: String
  
  init(screenTitle: String) {
    self.screenTitle = screenTitle
  }
}
