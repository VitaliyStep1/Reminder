//
//  ClosestViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation

class ClosestViewModel: ObservableObject {
  @Published var noEventsText: String?
  @Published var closestMonthEntities: [ClosestMonthEntity] = [] {
    didSet {
      updateNoEventsText()
    }
  }
  
  init() {
    updateNoEventsText()
  }
  
  func update() {
    self.closestMonthEntities = takeClosestMonthEntities()
  }
  
  func createEventClicked() {
    showCategoriesTab()
  }
  
  private func showCategoriesTab() {
    
  }
  
  private func updateNoEventsText() {
    noEventsText = closestMonthEntities.count == 0 ? "There are no events yet.\nPlease add one!" : nil
  }
  
  private func takeClosestMonthEntities() -> [ClosestMonthEntity] {
    return []
  }
}
