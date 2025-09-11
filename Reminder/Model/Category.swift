//
//  Category.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import CoreData

struct Category: Identifiable {
  let id: NSManagedObjectID
  let defaultKey: String
  var title: String
  let order: Int
  let isUserCreated: Bool
}
