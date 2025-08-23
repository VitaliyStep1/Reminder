//
//  MainTabView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct MainTabView: View {
  var body: some View {
    TabView {
      ClosestScreenView()
        .tabItem {
          Image(systemName: "house")
          Text("First")
        }
      CategoriesScreenView()
        .tabItem {
          Image(systemName: "music.note")
          Text("Second")
        }
    }
  }
}
