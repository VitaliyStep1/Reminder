//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
  let categoryId: NSManagedObjectID
  
  @Published var eventsEntity: [CategoryEventEntity] = []
  @Published var navigationTitle: String = "Events"
  
  init(categoryId: NSManagedObjectID) {
    self.categoryId = categoryId
  }
  
}
