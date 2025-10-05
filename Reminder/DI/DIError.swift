//
//  DIError.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 04.10.2025.
//

enum DIError: Error, CustomStringConvertible {
  case notRegistered(String)
  
  var description: String {
    switch self {
    case .notRegistered(let dependancy): return "Dependency not registered: \(dependancy)"
    }
  }
}
