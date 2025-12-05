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
import ReminderUserDefaultsStorage

struct UserDefaultsAssembly: Assembly {
  func assemble(container: Container) {
    container.register(UserDefaultsServiceProtocol.self) { _ in
      UserDefaultsService()
    }
    .inObjectScope(.container)

    container.register(DefaultRemindTimeServiceProtocol.self) { resolver in
      let appConfiguration = resolver.resolve(AppConfigurationProtocol.self)!
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!

      return DefaultRemindTimeService(appConfiguration: appConfiguration, userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.container)

    container.register(LanguageService.self) { resolver in
      let takeSettingsLanguageUseCase = resolver.resolve(TakeSettingsLanguageUseCaseProtocol.self)!

      return LanguageService(takeSettingsLanguageUseCase: takeSettingsLanguageUseCase)
    }
    .inObjectScope(.container)

    container.register(TakeDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.resolve(DefaultRemindTimeServiceProtocol.self)!
      return TakeDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }
    .inObjectScope(.transient)

    container.register(UpdateDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      return UpdateDefaultRemindTimeDateUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(TakeSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      return TakeSettingsLanguageUseCase(userDefaultsService: userDefaultsService)
    }
    .inObjectScope(.transient)

    container.register(UpdateSettingsLanguageUseCaseProtocol.self) { resolver in
      let userDefaultsService = resolver.resolve(UserDefaultsServiceProtocol.self)!
      let languageService = resolver.resolve(LanguageService.self)!
      return UpdateSettingsLanguageUseCase(userDefaultsService: userDefaultsService, languageService: languageService)
    }
    .inObjectScope(.transient)

    container.register(FetchDefaultRemindTimeDateUseCaseProtocol.self) { resolver in
      let defaultRemindTimeService = resolver.resolve(DefaultRemindTimeServiceProtocol.self)!
      return FetchDefaultRemindTimeDateUseCase(defaultRemindTimeService: defaultRemindTimeService)
    }
    .inObjectScope(.transient)
  }
}
