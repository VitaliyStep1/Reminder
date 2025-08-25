//
//  CategoryViewModel.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 25.08.2025.
//

import Foundation

class CategoryViewModel: ObservableObject {
  let categoryId: Int
  
  init(categoryId: Int) {
    self.categoryId = categoryId
  }
  
}
