//
//  Resolver+.swift
//  ReminderResolver
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject
import ReminderPersistenceContracts

// Don't use func resolve outside this file
// Instead add here computed property

extension Resolver {
  
  public var dbCategoriesServiceProtocol: DBCategoriesServiceProtocol {
    resolve(DBCategoriesServiceProtocol.self)!
  }
  
  public var dbEventsServiceProtocol: DBEventsServiceProtocol {
    resolve(DBEventsServiceProtocol.self)!
  }
}
