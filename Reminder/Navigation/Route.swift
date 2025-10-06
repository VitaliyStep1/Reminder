//
//  Untitled.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI

enum Route: Hashable {
  case start
  case splash
  case categories
  case category(ObjectId)
  case closest
}
