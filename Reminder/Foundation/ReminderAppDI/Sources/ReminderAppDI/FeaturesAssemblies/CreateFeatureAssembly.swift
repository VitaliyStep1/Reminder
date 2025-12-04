//
//  CreateFeatureAssembly.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.12.2025.
//

import SwiftUI
import Swinject
import ReminderCreate
import ReminderDomain
import ReminderDomainContracts
import ReminderNavigationContracts

@MainActor
struct CreateFeatureAssembly: Assembly {
  func assemble(container: Container) {
    container.register(CategoriesViewModel.self) { r in
      let fetchAllCategoriesUseCase = r.resolve(FetchAllCategoriesUseCaseProtocol.self)!
      let coordinator = r.resolve(CreateCoordinator.self)!
      return CategoriesViewModel(fetchAllCategoriesUseCase: fetchAllCategoriesUseCase, coordinator: coordinator)
    }

    container.register(CreateRouterProtocol.self) { _ in
      CreateRouter()
    }
    .inObjectScope(.container)

    container.register(EventViewStore.self) { resolver, eventScreenViewType in
      let router = resolver.resolve(CreateRouterProtocol.self)!
      return EventViewStore(eventScreenViewType: eventScreenViewType, router: router)
    }

    container.register(EventPresenter.self) { _, store in
      EventPresenter(store: store)
    }

    container.register(EventInteractor.self) { resolver, store, presenter in
      let createEventUseCase = resolver.resolve(CreateEventUseCaseProtocol.self)!
      let editEventUseCase = resolver.resolve(EditEventUseCaseProtocol.self)!
      let deleteEventUseCase = resolver.resolve(DeleteEventUseCaseProtocol.self)!
      let fetchEventUseCase = resolver.resolve(FetchEventUseCaseProtocol.self)!
      let fetchCategoryUseCase = resolver.resolve(FetchCategoryUseCaseProtocol.self)!
      let fetchDefaultRemindTimeDateUseCase = resolver.resolve(FetchDefaultRemindTimeDateUseCaseProtocol.self)!

      return EventInteractor(
        createEventUseCase: createEventUseCase,
        editEventUseCase: editEventUseCase,
        deleteEventUseCase: deleteEventUseCase,
        fetchEventUseCase: fetchEventUseCase,
        fetchCategoryUseCase: fetchCategoryUseCase,
        fetchDefaultRemindTimeDateUseCase: fetchDefaultRemindTimeDateUseCase,
        presenter: presenter,
        store: store
      )
    }
    
    container.register(CategoryViewModel.self) { (r: Resolver, categoryId: Identifier) in
      let fetchEventsUseCase = r.resolve(FetchEventsUseCaseProtocol.self)!
      let fetchCategoryUseCase = r.resolve(FetchCategoryUseCaseProtocol.self)!
      let router = r.resolve(CreateRouterProtocol.self)!
      return CategoryViewModel(categoryId: categoryId, fetchEventsUseCase: fetchEventsUseCase, fetchCategoryUseCase: fetchCategoryUseCase, router: router)
    }
    .inObjectScope(.transient)

    container.register(CreateCoordinator.self) { r in
      let categoriesScreenBuilder = r.resolve(CategoriesScreenBuilder.self)!
      let categoryScreenBuilder = r.resolve(CategoryScreenBuilder.self)!
      let eventScreenBuilder = r.resolve(EventScreenBuilder.self)!
      
      let router = r.resolve(CreateRouterProtocol.self)!
      let coordinator = CreateCoordinator(router: router, categoriesScreenBuilder: categoriesScreenBuilder, categoryScreenBuilder: categoryScreenBuilder, eventScreenBuilder: eventScreenBuilder)
      return coordinator
    }
    .inObjectScope(.container)
    
    container.register(CategoryScreenBuilder.self) { r in
      { categoryId in
        let viewModel = r.resolve(CategoryViewModel.self, argument: categoryId)!
        return AnyView(
          CategoryScreenView(viewModel: viewModel)
        )
      }
    }
    
    container.register(CategoriesScreenBuilder.self) { r in
      {
        let viewModel = r.resolve(CategoriesViewModel.self)!
        return AnyView(
          CategoriesScreenView(viewModel: viewModel)
        )
      }
    }
    
    container.register(EventScreenBuilder.self) { r in
      { eventScreenViewType in
        let eventViewStore = r.resolve(EventViewStore.self, argument: eventScreenViewType)!
        let eventPresenter = r.resolve(EventPresenter.self, argument: eventViewStore)!
        let eventInteractor = r.resolve(EventInteractor.self, arguments: eventViewStore, eventPresenter)!
        let viewModel = r.resolve(EventScreenBuilder.self)!
        return AnyView(
          EventScreenView(store: eventViewStore, interactor: eventInteractor)
        )
      }
    }
  }
}
