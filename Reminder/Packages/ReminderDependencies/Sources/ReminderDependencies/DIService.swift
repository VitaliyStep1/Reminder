//
//  DIContainer.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

import Swinject
import ReminderPersistenceContracts
import ReminderPersistence
import ReminderDomainContracts
import ReminderNavigation
import ReminderConfigurations
import ReminderNavigationContracts
import ReminderResolver

public final class DIService {
  let assembler: Assembler
  public var resolver: Resolver {
    assembler.resolver
  }
  
  public init() {
    assembler = Assembler([
      PersistenceAssembly(),
      DependencyAssembly()
    ])
    
#if DEBUG
    validateDependenciesDebugOnly()
#endif
  }
  
  private func validateDependenciesDebugOnly() {
    _ = ResolverPersistenceCheckService.checkDependencies(resolver: resolver)
    _ = ResolverCheckService.checkDependencies(resolver: resolver)
  }
}
