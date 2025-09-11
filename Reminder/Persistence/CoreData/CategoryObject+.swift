//
//  CategoryObject+.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 10.09.2025.
//

import Foundation


extension CategoryObject {
  func takeCategory() -> Category {
    Category(
      id: self.objectID,
      defaultKey: self.defaultKey ?? "",
      title: self.title ?? "",
      order: Int(self.order),
      isUserCreated: self.isUserCreated
    )
  }
}
