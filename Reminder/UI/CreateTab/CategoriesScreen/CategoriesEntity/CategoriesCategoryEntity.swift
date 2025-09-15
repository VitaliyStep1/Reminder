//
//  CategoriesCategoryEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

struct CategoriesCategoryEntity: Identifiable, Hashable {
  let id: ObjectId
  let title: String
  let eventsAmount: String
  
  init(category: Category) {
    self.id = category.id
    self.title = category.title
    self.eventsAmount = "0"
  }
}
