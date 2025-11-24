//
//  ChangeCategoryIdForEventService.swift
//  ReminderDomain
//
//  Created by Vitaliy Stepanenko on 21.10.2025.
//

import Foundation
import ReminderDomainContracts
import ReminderPersistenceContracts

class CalculateCategoryIdForEventService {
  private let dBEventsService: DBEventsServiceProtocol
  private let dBCategoriesService: DBCategoriesServiceProtocol
  
  public init(dBEventsService: DBEventsServiceProtocol, dBCategoriesService: DBCategoriesServiceProtocol) {
    self.dBEventsService = dBEventsService
    self.dBCategoriesService = dBCategoriesService
  }
  
  func calculateNewCategoryIdForEditingEvent(eventId: Identifier, remindRepeat: RemindRepeatEnum) async throws -> ObjectId? {
    let event = try await dBEventsService.fetchEvent(eventId: eventId)
    var newCategoryId: ObjectId? = nil
    if let categoryId = event.categoryId {
      if let category = try? await dBCategoriesService.fetchCategory(categoryId: categoryId) {
        let categoryGroup = category.categoryGroup
        if let sameGroupAllCategories = try? await dBCategoriesService.fetchAllCategoriesWithCategoryGroup(categoryGroup: categoryGroup) {
          newCategoryId = takeNewCategoryId(remindRepeat: remindRepeat, category: category, groupCategories: sameGroupAllCategories)
        }
      }
    }
    return newCategoryId
  }
  
  func calculateNewCategoryIdForCreatingEvent(categoryId: Identifier, remindRepeat: RemindRepeatEnum) async throws -> ObjectId? {
    var newCategoryId: ObjectId? = nil
    if let category = try? await dBCategoriesService.fetchCategory(categoryId: categoryId) {
      let categoryGroup = category.categoryGroup
      if let sameGroupAllCategories = try? await dBCategoriesService.fetchAllCategoriesWithCategoryGroup(categoryGroup: categoryGroup) {
        newCategoryId = takeNewCategoryId(remindRepeat: remindRepeat, category: category, groupCategories: sameGroupAllCategories)
      }
    }
    return newCategoryId
  }
  
  private func takeNewCategoryId(remindRepeat: RemindRepeatEnum, category: ReminderPersistenceContracts.Category, groupCategories: [ReminderPersistenceContracts.CategoryWithoutEventsAmount]) -> ObjectId? {
    let categoryRepeatEnum = CategoryRepeatEnum(fromRawValue: category.categoryRepeat)
    if categoryRepeatEnum.defaultRemindRepeat == remindRepeat {
      return nil
    }
    let groupCategoryWithNecessaryRemindRepeat = groupCategories.first { groupCategory in
      let groupCategoryRepeatEnum = CategoryRepeatEnum(fromRawValue: groupCategory.categoryRepeat)
      if groupCategoryRepeatEnum.defaultRemindRepeat == remindRepeat {
        return true
      }
      return false
    }
    return groupCategoryWithNecessaryRemindRepeat?.id
  }
}
