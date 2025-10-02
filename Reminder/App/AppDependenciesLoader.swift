//
//  AppDependenciesLoader.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 02.10.2025.
//

import Foundation

@MainActor
final class AppDependenciesLoader: ObservableObject {
  @Published var instance: AppDependencies?
  
  func load() async {
    guard instance == nil else {
      return
    }
    instance = await AppDependencies.make()
  }
}
