//
//  ViewFactoryProtocol.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 05.10.2025.
//

import SwiftUI

protocol ViewFactoryProtocol {
  associatedtype TypeView: View
  
  func make(_ route: Route) -> TypeView
}
