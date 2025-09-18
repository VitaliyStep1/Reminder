//
//  AppDependencies.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import CoreData

@MainActor
final class AppDependencies: ObservableObject {
  let container: NSPersistentContainer
  let dBCategoriesService: DBCategoriesService
  let dBEventsService: DBEventsService
  let defaultCategoriesDataService: DefaultCategoriesDataService
  let dataService: DataService
  let previewDataService: PreviewDataService?
  
  private init(container: NSPersistentContainer, previewDataService: PreviewDataService?) {
    self.container = container
    self.dBCategoriesService = DBCategoriesService(container: container)
    self.dBEventsService = DBEventsService(container: container)
    self.defaultCategoriesDataService = DefaultCategoriesDataService()
    self.dataService = DataService(
      dBCategoriesService: dBCategoriesService,
      dBEventsService: dBEventsService,
      defaultCategoriesDataService: defaultCategoriesDataService
    )
    self.previewDataService = previewDataService
  }
  
  static func make(isForPreview: Bool = false) async -> AppDependencies {
    let inMemory = false // Because in memory container does not support propertiesToGroupBy
    let container = PersistenceContainerService()
      .createPersistentContainer(inMemory: false)
    
    var previewService: PreviewDataService? = nil
    if isForPreview {
      previewService = PreviewDataService(
        dBCategoriesService: DBCategoriesService(container: container),
        dBEventsService: DBEventsService(container: container)
      )
      try? await previewService?.addDataForPreview()
    }
    
    return AppDependencies(container: container, previewDataService: previewService)
  }
}
