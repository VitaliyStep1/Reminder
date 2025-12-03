//
//  UserDefaultsAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import Swinject
import ReminderDomainContracts
import ReminderDomain
import ReminderConfigurations
import ReminderResolver
import ReminderUserDefaultsStorage

struct UserDefaultsAssembly: Assembly {
  func assemble(container: Container) {
    container.register(UserDefaultsServiceProtocol.self) { _ in
      UserDefaultsService()
    }
    .inObjectScope(.container)

    container.register(DefaultRemindTimeServiceProtocol.self) { resolver in
      let appConfiguration = resolver.appConfigurationProtocol
      let userDefaultsService = resolver.userDefaultsServiceProtocol

      return DefaultRemindTimeService(appConfiguration: appConfiguration, userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.container)

    container.register(LanguageServiceProtocol.self) { resolver in
      let takeSettingsLanguageUseCase = resolver.takeSettingsLanguageUseCaseProtocol

      return LanguageService(takeSettingsLanguageUseCase: takeSettingsLanguageUseCase)
    }
    .inObjectScope(.container)

    container.register(TakeDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.defaultRemindTimeServiceProtocol
      return TakeDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }
    .inObjectScope(.transient)

    container.register(UpdateDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.userDefaultsServiceProtocol
      return UpdateDefaultRemindTimeDateUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(TakeSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.userDefaultsServiceProtocol
      return TakeSettingsLanguageUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(UpdateSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.userDefaultsServiceProtocol
      let languageService = resolver.languageServiceProtocol
      return UpdateSettingsLanguageUseCase(userDefaultsService: userDefaultsService, languageService: languageService)
    }
    .inObjectScope(.transient)

    container.register(FetchDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.defaultRemindTimeServiceProtocol
      return FetchDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }
    .inObjectScope(.transient)
  }
}
