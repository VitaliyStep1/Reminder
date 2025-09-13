//
//  CategoryEventEntity.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 11.09.2025.
//

struct CategoryEventEntity: Identifiable {
  let id: ObjectId
  let title: String
  let comment: String?
}
