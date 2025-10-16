//
//  ResolverPersistenceCheckService.swift
//  ReminderPersistence
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject

public class ResolverPersistenceCheckService {
  public static func checkDependencies(resolver: Resolver) -> [Any] {
    let dependencies: [Any] = [
      resolver.persistenceContainerServiceProtocol,
      resolver.nsPersistentContainer,
    ]
    
    return dependencies
  }
}
