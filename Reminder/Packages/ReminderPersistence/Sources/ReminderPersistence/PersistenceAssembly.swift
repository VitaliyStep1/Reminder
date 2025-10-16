//
//  PersistenceAssembly.swift
//  ReminderPersistence
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import CoreData
import Swinject
import ReminderPersistenceContracts

public final class PersistenceAssembly: Assembly {
  
  private let inMemory: Bool
  
  public init(inMemory: Bool = false) {
    self.inMemory = inMemory
  }
  
  public func assemble(container: Container) {
    container.register(PersistenceContainerServiceProtocol.self) { _ in
      PersistenceContainerService()
    }
    .inObjectScope(.container)
    
    container.register(NSPersistentContainer.self) { [inMemory] resolver in
      let service = resolver.persistenceContainerServiceProtocol
      return service.createPersistentContainer(inMemory: inMemory)
    }
    .inObjectScope(.container)
    
    container.register(DBCategoriesServiceProtocol.self) { resolver in
      let persistentContainer = resolver.nsPersistentContainer
      return DBCategoriesService(container: persistentContainer)
    }
    .inObjectScope(.container)
    
    container.register(DBEventsServiceProtocol.self) { resolver in
      let persistentContainer = resolver.nsPersistentContainer
      return DBEventsService(container: persistentContainer)
    }
    .inObjectScope(.container)
  }
}
