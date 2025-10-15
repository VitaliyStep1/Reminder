//
//  DIContainer.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

import Swinject
import ReminderPersistenceContracts
import ReminderDomainContracts
import ReminderNavigation
import ReminderStartUI
import ReminderConfigurations
import ReminderNavigationContracts

public final class DIService {
  let assembler: Assembler
  public var resolver: Resolver {
    assembler.resolver
  }
  
  public init() {
    assembler = Assembler([DependencyAssembly()])
#if DEBUG
    validateDependenciesDebugOnly()
#endif
  }
  
  private func validateDependenciesDebugOnly() {
#if DEBUG
    let checks: [() -> Any?] = [
      { self.resolver.resolve(ViewFactoryProtocol.self) },
      { self.resolver.resolve(SplashScreenState.self) },
      { self.resolver.resolve(AppConfigurationProtocol.self)},
      { self.resolver.resolve(DataServiceProtocol.self) },
      { self.resolver.resolve(DefaultCategoriesDataServiceProtocol.self) },
      { self.resolver.resolve(PreviewDataServiceProtocol.self) },
      { self.resolver.resolve(DBCategoriesServiceProtocol.self) },
      { self.resolver.resolve(DBEventsServiceProtocol.self) },
    ]
    for check in checks {
      assert(check() != nil, "One or more dependencies are not registered.")
    }
#endif
  }
}
