//
//  Resolver+.swift
//  ReminderResolver
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import Swinject
import ReminderPersistenceContracts
import ReminderDomainContracts
import ReminderNavigationContracts
import ReminderConfigurations

// Don't use func resolve outside this file
// Instead add here computed property

extension Resolver {
  
  public var dbCategoriesServiceProtocol: DBCategoriesServiceProtocol {
    resolve(DBCategoriesServiceProtocol.self)!
  }
  
  public var dbEventsServiceProtocol: DBEventsServiceProtocol {
    resolve(DBEventsServiceProtocol.self)!
  }
  
  public var dataServiceProtocol: DataServiceProtocol {
    resolve(DataServiceProtocol.self)!
  }
  
  public var viewFactoryProtocol: ViewFactoryProtocol {
    resolve(ViewFactoryProtocol.self)!
  }
  
  public var defaultCategoriesDataServiceProtocol: DefaultCategoriesDataServiceProtocol {
    resolve(DefaultCategoriesDataServiceProtocol.self)!
  }
  
  public var appConfigurationProtocol: AppConfigurationProtocol {
    resolve(AppConfigurationProtocol.self)!
  }
  
  public var splashScreenState: SplashScreenState {
    resolve(SplashScreenState.self)!
  }
}
