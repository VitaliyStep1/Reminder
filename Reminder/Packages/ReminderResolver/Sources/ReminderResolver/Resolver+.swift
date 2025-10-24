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
import ReminderMainTabViewContracts
import ReminderUserDefaultsStorage

// Don't use func resolve outside this file
// Instead add here computed property

extension Resolver {
  
  public var dbCategoriesServiceProtocol: DBCategoriesServiceProtocol {
    resolve(DBCategoriesServiceProtocol.self)!
  }
  
  public var dbEventsServiceProtocol: DBEventsServiceProtocol {
    resolve(DBEventsServiceProtocol.self)!
  }
  
  public var setupInitialDataUseCaseProtocol: SetupInitialDataUseCaseProtocol {
    resolve(SetupInitialDataUseCaseProtocol.self)!
  }

  public var fetchAllCategoriesUseCaseProtocol: FetchAllCategoriesUseCaseProtocol {
    resolve(FetchAllCategoriesUseCaseProtocol.self)!
  }

  public var fetchCategoryUseCaseProtocol: FetchCategoryUseCaseProtocol {
    resolve(FetchCategoryUseCaseProtocol.self)!
  }

  public var fetchEventsUseCaseProtocol: FetchEventsUseCaseProtocol {
    resolve(FetchEventsUseCaseProtocol.self)!
  }

  public var fetchEventUseCaseProtocol: FetchEventUseCaseProtocol {
    resolve(FetchEventUseCaseProtocol.self)!
  }

  public var createEventUseCaseProtocol: CreateEventUseCaseProtocol {
    resolve(CreateEventUseCaseProtocol.self)!
  }

  public var editEventUseCaseProtocol: EditEventUseCaseProtocol {
    resolve(EditEventUseCaseProtocol.self)!
  }

  public var deleteEventUseCaseProtocol: DeleteEventUseCaseProtocol {
    resolve(DeleteEventUseCaseProtocol.self)!
  }
  
  public var takeDefaultRemindTimeDateUseCaseProtocol: TakeDefaultRemindTimeDateUseCaseProtocol {
    resolve(TakeDefaultRemindTimeDateUseCaseProtocol.self)!
  }
  
  public var updateDefaultRemindTimeDateUseCaseProtocol: UpdateDefaultRemindTimeDateUseCaseProtocol {
    resolve(UpdateDefaultRemindTimeDateUseCaseProtocol.self)!
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
  
  public var mainTabViewSelectionState: MainTabViewSelectionState {
    resolve(MainTabViewSelectionState.self)!
  }
  
  public var userDefaultsServiceProtocol: UserDefaultsServiceProtocol {
    resolve(UserDefaultsServiceProtocol.self)!
  }
}
