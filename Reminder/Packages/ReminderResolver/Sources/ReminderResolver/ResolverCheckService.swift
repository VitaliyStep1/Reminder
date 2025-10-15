//
//  ResolverCheckService.swift
//  ReminderResolver
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject

public class ResolverCheckService {
  public static func checkDependencies(resolver: Resolver) -> [Any] {
    let dependencies: [Any] = [
      resolver.dbCategoriesServiceProtocol,
      resolver.dbEventsServiceProtocol,
      resolver.dataServiceProtocol,
      resolver.viewFactoryProtocol,
    ]
    
    return dependencies
  }
}
