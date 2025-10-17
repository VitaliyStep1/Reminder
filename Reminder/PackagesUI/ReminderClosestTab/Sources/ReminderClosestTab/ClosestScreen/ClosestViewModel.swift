//
//  ClosestViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import Foundation
import ReminderMainTabViewContracts

public class ClosestViewModel: ObservableObject {
  let mainTabViewSelectionState: MainTabViewSelectionState
  @Published var noEventsText: String?
  @Published var closestMonthEntities: [ClosestMonthEntity] = [] {
    didSet {
      updateNoEventsText()
    }
  }
  
  public init(mainTabViewSelectionState: MainTabViewSelectionState) {
    self.mainTabViewSelectionState = mainTabViewSelectionState
    updateNoEventsText()
  }
  
  func update() {
    self.closestMonthEntities = takeClosestMonthEntities()
  }
  
  func createEventClicked() {
    showCategoriesTab()
  }
  
  private func showCategoriesTab() {
    mainTabViewSelectionState.selection = .create
  }
  
  private func updateNoEventsText() {
    noEventsText = closestMonthEntities.count == 0 ? "There are no events yet.\nPlease add one!" : nil
  }
  
  private func takeClosestMonthEntities() -> [ClosestMonthEntity] {
    return []
  }
}
