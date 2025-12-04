//
//  ScreenBuilders.swift
//  ReminderCreate
//
//  Created by Vitaliy Stepanenko on 04.12.2025.
//

import SwiftUI
import ReminderDomainContracts

public typealias CategoryScreenBuilder = (_ categoryId: Identifier) -> CategoryScreenView

public typealias CategoriesScreenBuilder = () -> CategoriesScreenView

public typealias EventScreenBuilder = (_ eventScreenViewType: EventScreenViewType) -> EventScreenView
