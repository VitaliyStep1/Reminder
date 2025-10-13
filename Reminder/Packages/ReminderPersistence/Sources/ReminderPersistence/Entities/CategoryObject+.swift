//
//  CategoryObject+.swift
//  ReminderPersistence
//
//  Created by Vitaliy Stepanenko on 08.10.2025.
//

import CoreData

public class CategoryObject: NSManagedObject {}

extension CategoryObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryObject> {
    NSFetchRequest<CategoryObject>(entityName: "CategoryObject")
  }
  
  @NSManaged public var defaultKey: String?
  @NSManaged public var identifier: UUID
  @NSManaged public var title: String?
  @NSManaged public var order: Int32
  @NSManaged public var isUserCreated: Bool
  
  @NSManaged public var events: Set<EventObject>
}
