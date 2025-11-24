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

  @Published var screenStateEnum: ClosestEntity.ScreenStateEnum
  
  private let noEventsText = TextEnum.closestNoEventsText.localized
  
  public init(mainTabViewSelectionState: MainTabViewSelectionState) {
    self.mainTabViewSelectionState = mainTabViewSelectionState
    
    screenStateEnum = .empty(title: noEventsText)
  }
  
  func createEventClicked() {
    showCategoriesTab()
  }
  
  private func showCategoriesTab() {
    mainTabViewSelectionState.selection = .create
  }
}
