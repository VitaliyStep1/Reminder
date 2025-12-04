//
//  ConfigurationsAssembly.swift
//  ReminderAppDI
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderConfigurations

struct ConfigurationsAssembly: Assembly {
  func assemble(container: Container) {
    container.register(AppConfigurationProtocol.self) { _ in
      AppConfiguration()
    }
    .inObjectScope(.container)
    
  }
}
