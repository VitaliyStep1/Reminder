//
//  EventObject+.swift
//  ReminderPersistence
//
//  Created by Vitaliy Stepanenko on 08.10.2025.
//

import CoreData

public class EventObject: NSManagedObject {}

extension EventObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<EventObject> {
    NSFetchRequest<EventObject>(entityName: "EventObject")
  }
  
  @NSManaged public var identifier: UUID
  @NSManaged public var title: String?
  @NSManaged public var date: Date?
  @NSManaged public var comment: String?
  @NSManaged public var remindRepeat: Int16
  @NSManaged public var remindTimeDate1: Date
  @NSManaged public var remindTimeDate2: Date?
  @NSManaged public var remindTimeDate3: Date?
  @NSManaged public var category: CategoryObject?
}
