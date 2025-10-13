//
//  MainTabView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI
import ReminderNavigationContracts

public struct MainTabView: View {
  @Environment(\.viewFactory) private var viewFactory
  
  public init() { }
  
  public var body: some View {
    TabView {
      if let viewFactory {
        viewFactory.make(.closest)
          .tabItem {
            Image(systemName: "house")
            Text("Closest events")
          }
        viewFactory.make(.categories)
          .tabItem {
            Image(systemName: "music.note")
            Text("Create event")
          }
      }
    }
  }
}
