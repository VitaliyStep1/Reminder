//
//  MainTabView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct MainTabView: View {
  @Environment(\.viewFactory) private var viewFactory
  
  var body: some View {
    TabView {
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
