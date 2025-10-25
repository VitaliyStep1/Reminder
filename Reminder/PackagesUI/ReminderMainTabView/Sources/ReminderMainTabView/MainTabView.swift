//
//  MainTabView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts
import ReminderMainTabViewContracts

public struct MainTabView: View {
  @Environment(\.viewFactory) private var viewFactory
  @EnvironmentObject var mainTabViewSelectionState: MainTabViewSelectionState
  
  public init() { }
  
  public var body: some View {
    TabView(selection: $mainTabViewSelectionState.selection) {
      if let viewFactory {
        viewFactory.make(.closest)
          .tabItem {
            Image(systemName: "house")
            Text("Closest events")
          }
          .tag(MainTabViewSelectionEnum.closest)
        viewFactory.make(.categories)
          .tabItem {
            Image(systemName: "music.note")
            Text("Create event")
          }
          .tag(MainTabViewSelectionEnum.create)
        viewFactory.make(.settings)
          .tabItem {
            Image(systemName: "gearshape")
            Text("Settings")
          }
          .tag(MainTabViewSelectionEnum.settings)
      }
    }
  }
}
