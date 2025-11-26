//
//  Resolver+.swift
//  ReminderPersistence
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject
import CoreData

extension Resolver {
  
  var persistenceContainerServiceProtocol: PersistenceContainerServiceProtocol {
    resolve(PersistenceContainerServiceProtocol.self)!
  }
  
  var nsPersistentContainer: NSPersistentContainer {
    resolve(NSPersistentContainer.self)!
  }
}
