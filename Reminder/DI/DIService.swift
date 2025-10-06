//
//  DIContainer.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

import Swinject

final class DIService {
//  static let shared = DIManager()
  let container: Container
  
  init() {
    container = Container()
    DependencyMap.registerDependencies(container: container, diService: self)
    validateDependenciesDebugOnly()
  }
  
//  func resolve<T>(_ type: T.Type) throws -> T {
//    if let dep = container.resolve(type) { return dep }
//#if DEBUG
//    assertionFailure("Failed to resolve: \(type)")
//#endif
//    throw DIError.notRegistered("\(type)")
//  }
  
  func resolve<T>(_ type: T.Type) -> T? {
    container.resolve(type)
  }
  
  private func validateDependenciesDebugOnly() {
#if DEBUG
    let checks: [() -> Any?] = [
      { self.container.resolve(ViewFactory.self) },
      { self.container.resolve(SplashScreenState.self) },
      { self.container.resolve(AppConfigurationProtocol.self)},
      { self.container.resolve(DataServiceProtocol.self) },
      { self.container.resolve(DefaultCategoriesDataServiceProtocol.self) },
      { self.container.resolve(PreviewDataServiceProtocol.self) },
      { self.container.resolve(DBCategoriesServiceProtocol.self) },
      { self.container.resolve(DBEventsServiceProtocol.self) },
    ]
    for check in checks {
      assert(check() != nil, "One or more dependencies are not registered.")
    }
#endif
  }
}
