//
//  PersistenceContainerServiceProtocol.swift
//  ReminderPersistenceContracts
//
//  Created by Vitaliy Stepanenko on 15.10.2025.
//

import CoreData

protocol PersistenceContainerServiceProtocol {
  func createPersistentContainer(inMemory: Bool) -> NSPersistentContainer
}
